//
//  ULTestKeywordManager.m
//  UpLive
//
//  Created by jianwei on 9/18/16.
//  Copyright © 2016 AsiaInnovations. All rights reserved.
//

#import "ULTestKeywordManager.h"
#import "ULKeywordFilterManager.h"
@implementation ULTestKeywordManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static ULTestKeywordManager *testManager = nil;
    dispatch_once(&onceToken, ^{
        testManager = [[ULTestKeywordManager alloc] init];
    });
    return testManager;
}

- (void)test{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePaht = [[NSBundle mainBundle] pathForResource:@"test" ofType:@".txt"];
        NSString *text = [[NSString alloc] initWithContentsOfFile:filePaht encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"%@",text);
        
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (int i=0; i<10000; i++) {
            NSInteger index = arc4random()%[text length];
            NSInteger index2 = arc4random()%[text length];
            NSInteger start = MIN(index, index2);
            NSInteger end = MAX(index, index);
            NSString *subText  = [text substringWithRange:NSMakeRange(start, end - start +1)];
            [mutArr addObject:subText];
        }
        
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self testFilter:mutArr];
                    });
        
    });
}


static NSArray *testArr = nil;

- (void)testFilter:(NSArray *)mutArr{
    testArr = mutArr;
    NSThread *testThread = [[NSThread alloc] initWithTarget:self selector:@selector(testFilterArrStart ) object:nil];
    [testThread setName:@"testFilterThread"];
    [testThread start];
 }

- (void)testFilterArrStart{
    [self testFilterArr];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
}

- (void)testFilterArr{
    static NSInteger index = 0;
    NSDate *beginDate = [NSDate date];
    if (index < [testArr count]) {
        NSInteger count = arc4random()%15 + 10;
        count = [testArr count];
            NSArray *subArr = nil;
            if (index + count <= [testArr count]) {
                subArr = [testArr subarrayWithRange:NSMakeRange(index, count)];
            }else{
                subArr = [testArr subarrayWithRange:NSMakeRange(index, [testArr count] - index)];
            }
            for (int i= 0; i<[subArr count]; i++) {
                [[ULKeywordFilterManager shareInstance] isContainsProhibitedWords:subArr[i]];
            }
            index = index + count;
        NSDate *endDate = [NSDate date];
        NSLog(@"parse count = %zd, usedtime = %f",count,[endDate timeIntervalSinceDate:beginDate]);
        [self testFilterArr];
            [self performSelector:@selector(testFilterArr) withObject:nil afterDelay:.01];
    }
}
@end
