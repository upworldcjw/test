//
//  ULAnimationBaseView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/28.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationBaseView.h"


@implementation ULAnimationBaseView{
    __weak ULAvatarView *_avatarView;
}

-(void)dealloc{
    [_avatarView removeFromSuperview];
}

- (void)setAvatar:(NSString *)avatar andName:(NSString *)name{
    _avatar = avatar;
    _name = name;
}

- (CGPoint)avatarPointForRelative:(CGFloat)parm{
    NSAssert(NO, @"must overwrite");
    return CGPointZero;
}

//- (NSArray *)keyTimesForGroupKey:(NSString *)groupKey{
//    NSAssert(NO, @"must overwrite");
//    return  @[];
//}
//
//- (NSArray *)pathPointsForGroupKey:(NSString *)groupKey{
//    NSAssert(NO, @"must overwrite");
//    return  @[];
//}

- (CAAnimationGroup *)groupAnimationForKey:(NSString *)groupKey{
    NSAssert(NO, @"must overwrite");
    return nil;
}

- (void)doAvatarAnimationonView:(UIView *)onView{
    [self doAvatarAnimationonView:onView setting:NULL];
}

- (void)doAvatarAnimationonView:(UIView *)onView setting:(void (^)(ULAvatarView *))setBlock{
    ULAvatarView *avatarView = [[ULAvatarView alloc] initWithImgSize:CGSizeMake(30, 30) andName:self.name?self.name:@"Name"];
    //    [avatarView setBackgroundColor:[UIColor redColor]];
    [onView addSubview:avatarView];
    avatarView.transform = CGAffineTransformMakeRotation(-15.0/180 * M_PI);
    avatarView.layer.anchorPoint = CGPointMake(0, 0);
    avatarView.layer.position = [self avatarPointForRelative:0];
    if (setBlock) {
        setBlock(avatarView);
    }
    [avatarView.layer addAnimation:[self groupAnimationForKey:@"avatar"] forKey:@"avatar"];
    _avatarView = avatarView;
}

@end
