//
//  ViewController.m
//  TestInstanceMemorySize
//
//  Created by JianweiChen on 2020/2/24.
//  Copyright © 2020 inke. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
// Person.h
@interface Person : NSObject
/** name */
@property (nonatomic, copy) NSString *name;
/** age */
@property (nonatomic, assign) int age;

/** 学校 */
@property (nonatomic, copy) NSString *school;
/** 玩具 */
@property (nonatomic, strong) NSArray *toys;
/** 书 */
@property (nonatomic, assign) short bookCount;

@end

// Person.m
@implementation Person
{
    NSString *childhoodName;
    short bookCount2;
}
@end

// LittlePerson.h
@interface LittlePerson : Person

@end

// LittlePerson.m
@implementation LittlePerson

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // ViewController.m
     size_t size = class_getInstanceSize([Person class]);
     NSLog(@"%zu", size);
     
     // ViewController.m
     size = class_getInstanceSize([LittlePerson class]);
     NSLog(@"%zu", size);
     size = class_getInstanceSize([NSObject class]);
     
 //    size = class_getInstanceSize([NSObject new]);
     NSLog(@"%zu", size);

}


@end
