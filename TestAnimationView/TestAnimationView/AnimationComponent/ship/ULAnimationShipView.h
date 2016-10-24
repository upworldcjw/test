//
//  ShipView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ULAnimationBaseView.h"

@interface ULAnimationShipView : ULAnimationBaseView

- (instancetype)initWithImageName:(NSString *)imageName;

- (void)animation;

@end
