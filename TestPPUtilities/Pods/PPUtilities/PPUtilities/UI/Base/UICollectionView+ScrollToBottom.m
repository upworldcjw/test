//
//  UICollectionView+ScrollToBottom.m
//  pengpeng
//
//  Created by jianwei.chen on 15/12/3.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "UICollectionView+ScrollToBottom.h"

@implementation UICollectionView (ScrollToBottom)
- (void)nb_scrollToBottom{
    NSInteger kSection = self.numberOfSections;
    NSInteger i = (kSection -1);
    for( ;i >= 0;i--){
        NSInteger numOfRow = [self numberOfItemsInSection:i];
        if (numOfRow > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numOfRow-1 inSection:i];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
            break;
        }
    }
}

- (void)nb_scrollToTop{
    [self setContentOffset:CGPointZero animated:YES];
}
@end
