//
//  ViewController.m
//  TestEqual
//
//  Created by JianweiChenJianwei on 2017/1/11.
//  Copyright © 2017年 UL. All rights reserved.
//

#import "ViewController.h"

//#define TestWrong

#define TestWrong_MoreInfo

//#define TestRight


#ifdef TestWrong
///声明：这个是不完善的实现案例。用于对比用
@interface Person : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;

@end

@implementation Person

- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name{
    if (self = [super init]) {
        self.uid = uid;
        self.name = name;
    }
    return self;
}


- (BOOL)isEqual:(Person *)object{
    BOOL result;
    if (self == object) {
        result = YES;
    }else{
        if (object.uid == self.uid) {
            result = YES;
        }else{
            result = NO;
        }
    }
    NSLog(@"%@ compare with %@ result = %@",self,object,result ? @"Equal":@"NO Equal");
    return result;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%p(%ld,%@)",self,self.uid,self.name];
}

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableSet *mutSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutSet = [NSMutableSet set];
    Person *person1 = [[Person alloc] initWithID:1 name:@"nihao"];
    Person *person2 = [[Person alloc] initWithID:2 name:@"nihao2"];
    [self.mutSet addObject:person1];
    NSLog(@"add %@",person1);
    [self.mutSet addObject:person2];
    NSLog(@"add %@",person2);
    NSLog(@"count = %ld",self.mutSet.count);
    
    Person *person3 = [[Person alloc] initWithID:1 name:@"nihao"];
    [self.mutSet addObject:person3];
    NSLog(@"add %@",person3);
    NSLog(@"count = %d",self.mutSet.count);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

#endif


#ifdef TestWrong_MoreInfo
///测试案例,数据对比用
@interface Person : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;

@end

@implementation Person

- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name{
    if (self = [super init]) {
        self.uid = uid;
        self.name = name;
    }
    return self;
}


- (BOOL)isEqual:(Person *)object{
    BOOL result;
    if (self == object) {
        result = YES;
    }else{
        if (object.uid == self.uid) {
            result = YES;
        }else{
            result = NO;
        }
    }
    NSLog(@"%@ compare with %@ result = %@",self,object,result ? @"Equal":@"NO Equal");
    return result;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"%p(%ld,%@)",self,self.uid,self.name];
}

- (NSUInteger)hash{
    NSUInteger hashValue = [super hash];
//    NSUInteger hashValue = self;//和上面一行[super hash]等价
    NSLog(@"hash = %lud,addressValue = %lud,address = %p",(NSUInteger)hashValue,(NSUInteger)self,self);
    return hashValue;
}

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableSet *mutSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutSet = [NSMutableSet set];
    Person *person1 = [[Person alloc] initWithID:1 name:@"nihao"];
    Person *person2 = [[Person alloc] initWithID:2 name:@"nihao2"];
    NSLog(@"begin add %@",person1);
    [self.mutSet addObject:person1];
    NSLog(@"after add %@",person1);
    
    NSLog(@"begin add %@",person2);
    [self.mutSet addObject:person2];
    NSLog(@"after add %@",person2);
    
    NSLog(@"count = %d",self.mutSet.count);
    
    Person *person3 = [[Person alloc] initWithID:1 name:@"nihao"];
    NSLog(@"begin add %@",person3);
    [self.mutSet addObject:person3];
    NSLog(@"after add %@",person3);
    
    NSLog(@"count = %d",self.mutSet.count);
    
//    Person *person4 = [[Person alloc] initWithID:2 name:@"nihao"];
//    NSLog(@"begin add %@",person4);
//    [self.mutSet addObject:person4];
//    NSLog(@"after add %@",person4);
//    
//    
//    NSLog(@"count = %d",self.mutSet.count);
//    
//    Person *person5 = [[Person alloc] initWithID:3 name:@"nihao"];
//    NSLog(@"begin add %@",person5);
//    [self.mutSet addObject:person5];
//    NSLog(@"after add %@",person5);
//    
//    
//    Person *person6 = [[Person alloc] initWithID:3 name:@"nihao"];
//    NSLog(@"begin add %@",person6);
//    [self.mutSet addObject:person6];
//    NSLog(@"after add %@",person6);
//    
//    NSLog(@"count = %d",self.mutSet.count);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
#endif


#ifdef TestRight
///正确的测试案例
@interface Person : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;

@end

@implementation Person

- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name{
    if (self = [super init]) {
        self.uid = uid;
        self.name = name;
    }
    return self;
}


- (BOOL)isEqual:(Person *)object{
    BOOL result;
    if (self == object) {
        result = YES;
    }else{
        if (object.uid == self.uid) {
            result = YES;
        }else{
            result = NO;
        }
    }
    NSLog(@"%@ compare with %@ result = %@",self,object,result ? @"Equal":@"NO Equal");
    return result;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"%p(%ld,%@)",self,self.uid,self.name];
}

- (NSUInteger)hash{
    NSUInteger hashValue = self.uid; //在这里只需要比较uid就行。这样的话就满足如果两个实例相等，那么他们的hash一定相等，但反过来hash值相等，那么两个实例不一定相等。但是在Person这个实例中，hash值相等那么实例一定相等。（不考虑继承之类的）
    NSLog(@"hash = %lu,addressValue = %lu,address = %p",(NSUInteger)hashValue,(NSUInteger)self,self);
    return hashValue;
}

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableSet *mutSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutSet = [NSMutableSet set];
    Person *person1 = [[Person alloc] initWithID:1 name:@"nihao"];
    Person *person2 = [[Person alloc] initWithID:2 name:@"nihao2"];
    NSLog(@"begin add %@",person1);
    [self.mutSet addObject:person1];
    NSLog(@"after add %@",person1);
    
    NSLog(@"begin add %@",person2);
    [self.mutSet addObject:person2];
    NSLog(@"after add %@",person2);
    
    NSLog(@"count = %d",self.mutSet.count);
    
    Person *person3 = [[Person alloc] initWithID:1 name:@"nihao"];
    NSLog(@"begin add %@",person3);
    [self.mutSet addObject:person3];
    NSLog(@"after add %@",person3);
    
    NSLog(@"count = %d",self.mutSet.count);
    
    Person *person4 = [[Person alloc] initWithID:3 name:@"nihao"];
    NSLog(@"begin add %@",person4);
    [self.mutSet addObject:person4];
    NSLog(@"after add %@",person4);
//
//    
//    NSLog(@"count = %d",self.mutSet.count);
//    
//    Person *person5 = [[Person alloc] initWithID:3 name:@"nihao"];
//    NSLog(@"begin add %@",person5);
//    [self.mutSet addObject:person5];
//    NSLog(@"after add %@",person5);
//    
//    
//    Person *person6 = [[Person alloc] initWithID:3 name:@"nihao"];
//    NSLog(@"begin add %@",person6);
//    [self.mutSet addObject:person6];
//    NSLog(@"after add %@",person6);
//    
//    NSLog(@"count = %d",self.mutSet.count);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

#endif

