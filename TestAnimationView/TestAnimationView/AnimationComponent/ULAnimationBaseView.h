//
//  ULAnimationBaseView.h
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/28.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ULAnimationDelegate.h"
#import "ULAvatarView.h"
@interface ULAnimationBaseView : UIView

@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,weak) id<ULAnimationDelegate> delegate;

- (void)setAvatar:(NSString *)avatar andName:(NSString *)name;

- (void)doAvatarAnimationonView:(UIView *)onView;

- (void)doAvatarAnimationonView:(UIView *)onView setting:(void (^)(ULAvatarView *avatar))setBlock;

@end
