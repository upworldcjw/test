//
//  MJRefreshOnBottomAutoFooter.m
//  Pods
//
//  Created by ios_feng on 15/12/25.
//
//

#import "MJRefreshOnBottomAutoFooter.h"

@implementation MJRefreshOnBottomAutoFooter

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.mj_y = MAX(self.scrollView.bounds.size.height, self.scrollView.mj_contentH) ;
}

@end
