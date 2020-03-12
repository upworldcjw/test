//
//  YQAsyncBlock.m
//  YQAsyncBlock
//
//  Created by Yaqiang Wang on 2018/11/19.
//  Copyright © 2018 Yaqiang Wang. All rights reserved.
//

#import "YQAsyncBlock.h"
#define YQ_JMP_CONTINUE 1
#define YQ_JMP_DONE 2
#define YQ_DEFAULT_STACK_SIZE (256 * 1024)
#define yq_is_null(arg) (!(arg) || [(arg) isKindOfClass:NSNull.self])
#define yq_arg_or_nil(arg) (is_null(arg) ? nil : arg)

@implementation YQResult

-(instancetype)initWithValue:(id)vlaue error:(id)error done:(BOOL)done{
    if (self = [super init]) {
        _value = vlaue;
        _error = error;
        _done = done;
    }
    return self;
}
@end

@interface YQAsyncBlock(){
    id _block;
    NSMethodSignature *_signature;
    int *_ev_leave;
    int *_ev_entry;
    BOOL _ev_entry_valid;
    
    void *_stack;
    int _stack_size;
}

@property(nonatomic,strong)id value;
@property(nonatomic,strong)id error;
@property(nonatomic)BOOL done;
@property (nonatomic, weak) YQAsyncBlock * nest;

@end

static NSPointerArray *YQWeakStackArray;
@implementation YQAsyncBlock

+(void)load{
    YQWeakStackArray = [NSPointerArray weakObjectsPointerArray];
}

YQAsyncBlock * yq_async(dispatch_block_t block){
//    NSLog(@"======yq_async start");
    YQAsyncBlock *asyncBlock = [[YQAsyncBlock alloc] initWithBlock:block];
    YQResult *result = [asyncBlock next];
    [asyncBlock step:result asyncBlock:asyncBlock];
//    NSLog(@"======yq_async end");
    return asyncBlock;
}
YQResult *yq_await(id value){
//    NSLog(@"yq_await===start");
    YQAsyncBlock *block = [YQAsyncBlock stackTop];
    return [block yield:value];
}
-(instancetype)initWithBlock:(dispatch_block_t)block{
    if (self = [super init]) {
        NSAssert(block != nil, @"block 不能为空");
        _block = [block copy];
        _signature = YQMethodSignatureForBlock(block);
        NSAssert(_signature != nil, @"没有获取到block的签名");
        _stack = calloc(1, YQ_DEFAULT_STACK_SIZE);
        _stack_size = YQ_DEFAULT_STACK_SIZE;
        _ev_leave = calloc(1, sizeof(jmp_buf));
        _ev_entry = calloc(1, sizeof(jmp_buf));
    }
    return self;
}

-(id)yield:(id)value{
    id yield_value = value;
    if ([value isKindOfClass:self.class]) {
        //嵌套的迭代器
        self.nest = (YQAsyncBlock *)value;
    }
    
next: {
    YQResult * result = [self.nest next];
    if (result) {
        yield_value = result.value;
    }
    
    _ev_entry_valid = YES;
    if (setjmp(_ev_entry) == 0) {
        self.value = yield_value;
        longjmp(_ev_leave, YQ_JMP_CONTINUE);
    }else{
//        NSLog(@"=======");
    }
}
    
    //嵌套迭代器还可继续
    if (self.nest && !self.nest.done) {
        goto next;
    }
    
    self.nest = nil;
    
    return self.value;
}

-(YQResult *)next{
    return [self next:nil setValue:NO];
}

-(YQResult *)next:(id)value{
    return [self next:value setValue:YES];
}

-(YQResult *)next:(id)value setValue:(BOOL)setValue{
    if (_done) {
        return [[YQResult alloc] initWithValue:_value error:_error done:_done];
    }
    [YQAsyncBlock stackPush:self];
    int leave_value = setjmp(_ev_leave);
    if (leave_value == 0) {
        if (_ev_entry_valid) {
            if (setValue) {
                self.value = value;
            }
            longjmp(_ev_entry, YQ_JMP_CONTINUE);
        }else{
            intptr_t sp = (intptr_t)(_stack + _stack_size);
            sp -= 256;
            sp &= ~0x07;
#if defined(__arm__)
            asm volatile("mov sp, %0" : : "r"(sp));
#elif defined(__arm64__)
            asm volatile("mov sp, %0" : : "r"(sp));
#elif defined(__i386__)
            asm volatile("movl %0, %%esp" : : "r"(sp));
#elif defined(__x86_64__)
            asm volatile("movq %0, %%rsp" : : "r"(sp));
#endif
            [self wrapper];
        }
    }else if(leave_value == YQ_JMP_CONTINUE){
//        NSLog(@"YQ_JMP_CONTINUE");
    }else if(leave_value == YQ_JMP_DONE){
        _done = YES;
    }
    [YQAsyncBlock stackPop];
    return [[YQResult alloc] initWithValue:_value error:_error done:_done];
    
}

-(void)step:(YQResult *)result asyncBlock:(YQAsyncBlock *)asyncBlock{
    if (!result.done) {
        id value = result.value;
        //oc闭包
        if ([value isKindOfClass:NSClassFromString(@"__NSGlobalBlock__")] ||
            [value isKindOfClass:NSClassFromString(@"__NSStackBlock__")] ||
            [value isKindOfClass:NSClassFromString(@"__NSMallocBlock__")]
            ) {
            ((YQAsyncClosure)value)(^(id value, id error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    YQResult *result_tmp = [asyncBlock next: [[YQResult alloc] initWithValue:value error:error done:NO]];
                    [asyncBlock step:result_tmp asyncBlock:asyncBlock];
                });
            });
        }
        else {
            YQResult *old_result = result;
            result = [asyncBlock next: old_result];
            [asyncBlock step:result asyncBlock:asyncBlock];
        }
    }
    else {
    }
}

-(void)wrapper{
    id value = nil;
    if (_block && _signature) {
        if (_signature.methodReturnType[0] == 'v') { //void类型
            ((void (^)(void))_block)();
        }else{
            value = ((id (^)(void))_block)();
        }
        self.value = value;
        longjmp(_ev_leave, YQ_JMP_DONE);
        assert(0);
    }
}

+(void)stackPush:(id)object{
    [YQWeakStackArray addPointer:(__bridge void * _Nullable)(object)];
}

+(id)stackPop{
    NSInteger count = YQWeakStackArray.count;
    if (count == 0) {
        return nil;
    }
    id obj = [YQWeakStackArray pointerAtIndex:count-1];
    [YQWeakStackArray removePointerAtIndex:count-1];
    return obj;
}

+(id)stackTop{
    NSInteger count = YQWeakStackArray.count;
    if (count == 0) {
        return nil;
    }
    id obj = [YQWeakStackArray pointerAtIndex:count-1];
    return obj;
}



struct YQBlockStruct{
    void *isa; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct block_descriptor {
        unsigned long int reserved;    // NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // optional helper functions
        void (*copy_helper)(void *dst, void *src);     // IFF (1<<25) //只有flag是1<<25才有这个值
        void (*dispose_helper)(void *src);             // IFF (1<<25) //只有flag是1<<25才有这个值
        // required ABI.2010.3.16
        const char *signature;                         // IFF (1<<30)
    } *descriptor;
    // imported variables
};
enum {
    YQ_BLOCK_IS_NOESCAPE      =  (1 << 23),
    YQ_BLOCK_HAS_COPY_DISPOSE =  (1 << 25),
    YQ_BLOCK_HAS_CTOR =          (1 << 26), // helpers have C++ code
    YQ_BLOCK_IS_GLOBAL =         (1 << 28),
    YQ_BLOCK_HAS_STRET =         (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    YQ_BLOCK_HAS_SIGNATURE =     (1 << 30),
};

static NSMethodSignature *YQMethodSignatureForBlock(id block) {
    if (!block)
        return nil;
    //http://bbs.iosre.com/t/block/6779
    struct YQBlockStruct *blockRef = (__bridge struct YQBlockStruct *)block;
    if (blockRef->flags & YQ_BLOCK_HAS_SIGNATURE) { //有签名
        void *signatureLocation = blockRef->descriptor;
        signatureLocation += sizeof(unsigned long int);
        signatureLocation += sizeof(unsigned long int);
        
        if (blockRef->flags & YQ_BLOCK_HAS_COPY_DISPOSE) {
            signatureLocation += sizeof(void(*)(void *dst, void *src));
            signatureLocation += sizeof(void (*)(void *src));
        }
        
        const char *signature = (*(const char **)signatureLocation);
        return [NSMethodSignature signatureWithObjCTypes:signature];
    }
    return 0;
}

-(void)dealloc{
    NSLog(@"YQAsyncBlock dealloc");
}
@end
