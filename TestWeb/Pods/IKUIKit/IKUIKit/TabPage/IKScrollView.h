//
//  IKScrollView.h
//  inke
//
//  Created by Chenxiaocheng on 15/7/21.
//  Copyright (c) 2015年 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKScrollView : UIScrollView

+ (id)initWithPageNumber:(NSInteger)number views:(NSArray *)views frame:(CGRect)frame;

@end
