//
//  IKTLPersonalMaskView.h
//  inke
//
//  Created by JianweiChen on 2018/5/30.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTLPersonalMaskView : UIView

@property (nonatomic, copy) void (^tapBlock)(void);

+ (CGFloat)properHeight;

@end
