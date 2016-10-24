//
//  Person.m
//  DylibTest
//
//  Created by jianwei on 9/29/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "Person.h"
#import <UIKit/UIKit.h>
@implementation Person
- (void)printName{
    if (self.name.length > 0) {
        NSLog(@"name = %@",_name);
    }else{
        NSLog(@"name empty");
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The Second Alert" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"done", nil];
    [alert show];
}

@end
