//
//  IKFlipView.h
//  IKUIKit
//
//  Created by zld on 17/07/2017.
//  Copyright © 2017 zld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKFlipView : UIView

@property (nonatomic, strong) NSArray<UIView *> *flipViews;

- (instancetype)initWithFlipViews:(NSArray<UIView *> *)flipViews;

- (void)start;

- (void)stop;

@end
