//
//  YQAsyncBlock.h
//  YQAsyncBlock
//
//  Created by Yaqiang Wang on 2018/11/19.
//  Copyright © 2018 Yaqiang Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class YQAsyncBlock;

@class YQResult;

typedef void (^YQAsyncCallback)(id _Nullable value, id _Nullable error);
typedef void (^YQAsyncClosure)(YQAsyncCallback _Nonnull callback);

YQAsyncBlock * yq_async(dispatch_block_t block);

YQResult *yq_await(id value);

@interface YQAsyncBlock : NSObject{
    
}
@end

@interface YQResult:NSObject
@property(nonatomic,strong)id value;
@property(nonatomic,strong)id error;
@property(nonatomic)BOOL done;
-(instancetype)initWithValue:(id)vlaue error:(id)error done:(BOOL)done;
@end
NS_ASSUME_NONNULL_END
