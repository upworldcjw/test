//
//  UITableView+ScollToBottom.m
//  pengpeng
//
//  Created by jianwei.chen on 15/12/3.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "UITableView+ScrollToBottom.h"

@implementation UITableView (ScrollToBottom)
- (void)nb_scrollToBottom{
    NSInteger section = self.numberOfSections;
    for(NSInteger i = section -1 ;i >= 0;i--){
        NSInteger numOfRow = [self numberOfRowsInSection:i];
        if (numOfRow > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numOfRow-1 inSection:i];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
    }
}

- (void)nb_scrollToTop{
    [self setContentOffset:CGPointZero animated:YES];
}

@end
