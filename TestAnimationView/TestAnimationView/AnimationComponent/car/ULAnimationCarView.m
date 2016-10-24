//
//  CarView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationCarView.h"
#import "OLImageView.h"
#import "OLImage.h"
#import "ULAvatarView.h"
@interface ULAnimationCarView()
@property (nonatomic,strong) UIImageView *gifImgView;
@property (nonatomic,strong) ULAvatarView *avatarView;
@property (nonatomic,assign) CGPoint beginPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat endScale;
@end

@implementation ULAnimationCarView

- (void)dealloc{
    NSLog(@"ULAnimationCarView dealloc");
}

- (instancetype)initWithImageName:(NSString *)imageName{
    UIImage *image = [self properSizeForImageName:imageName];
    CGSize size = CGSizeMake(image.size.width/2.0 * [[self class] scaleFactor],image.size.height/2.0 * [[self class] scaleFactor]);
    if(self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]){
       
        OLImageView *gifImageView = [[OLImageView alloc] initWithImage:nil];
        gifImageView.image = image;
        self.gifImgView = gifImageView;
        [self.gifImgView setFrame:self.bounds];
        [self addSubview:gifImageView];
        self.endScale = 2;
        self.userInteractionEnabled = NO;
    }
    return  self;
}

- (UIImage *)properSizeForImageName:(NSString *)imageName{
    NSString *imagePath;
    if (imageName.length == 0) {
        imagePath = [[NSBundle mainBundle] pathForResource:@"保时捷" ofType:@"gif"];
    }else{
        imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    }
    NSAssert(imagePath.length, @"image not exist");
    UIImage *image = [OLImage imageWithContentsOfFile:imagePath];
    return  image;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        NSAssert(0, @"not support");
    }
    return  self;
}

- (CGPoint)pointForRelative:(CGFloat)parm{
    CGFloat dy = self.endPoint.y - self.beginPoint.y;
    CGFloat dx = self.endPoint.x - self.beginPoint.x;
    CGFloat x = self.beginPoint.x + dx * parm;
    CGFloat y = self.beginPoint.y + dy * parm;
    CGPoint point = CGPointMake(x, y);
    NSLog(@"%@",NSStringFromCGPoint(point));
    return point;
}

- (CGPoint)avatarPointForRelative:(CGFloat)parm{
    CGPoint point = [self pointForRelative:parm];
    
//    point.x += self.gifImgView.frame.size.width/2.0 + (self.endScale -1 ) *self.gifImgView.frame.size.width * parm * 0.6  - 0;
//    point.y += (self.endScale -1 ) * self.gifImgView.frame.size.height * parm;
//    self.gifImgView.frame.size.height
//    point.y -= 50;
    return point;
}

- (NSArray *)pathPointsForGroupKey:(NSString *)groupKey{
    NSArray *points = nil;
    if (![groupKey isEqualToString:@"avatar"]) {
        points =  @[[NSValue valueWithCGPoint:[self pointForRelative:.0]],[NSValue valueWithCGPoint:[self pointForRelative:.4]],[NSValue valueWithCGPoint:[self pointForRelative:.5]],[NSValue valueWithCGPoint:[self pointForRelative:1]]];
    }else{
        points =  @[[NSValue valueWithCGPoint:[self avatarPointForRelative:.0]],[NSValue valueWithCGPoint:[self avatarPointForRelative:.4]],[NSValue valueWithCGPoint:[self avatarPointForRelative:.5]],[NSValue valueWithCGPoint:[self avatarPointForRelative:1]]];
    }
    return  points;
}

- (void)animation{
    if (self.superview == nil) {
        NSAssert(NO, @"invoke after addsubview");
    }
    
    self.beginPoint = CGPointMake(self.superview.frame.size.width, 70);
    
    self.endPoint = CGPointMake(-self.frame.size.width*self.endScale, self.superview.frame.size.height/2.0);
    
    CGRect newFrame = self.frame;
    newFrame.origin = self.beginPoint;
    self.frame = newFrame;

    [self doCoreAnimation];
    [self doAvatarAnimationonView:self.superview];
}

//    *  kCAMediaTimingFunctionLinear            线性,即匀速
//    *  kCAMediaTimingFunctionEaseIn            先慢后快
//    *  kCAMediaTimingFunctionEaseOut           先快后慢
//    *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
//    *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.

- (CGFloat)scaleForFactor:(CGFloat)factor{
    CGFloat from3DScale = 1;
    CGFloat to3DScale = self.endScale;
    return (to3DScale - from3DScale)*factor + from3DScale;
}

- (CATransform3D)transfromFroFactor:(CGFloat)factor{
    CGFloat from3DScale = [self scaleForFactor:factor];
    return CATransform3DMakeScale(from3DScale, from3DScale, from3DScale);
}

- (CAAnimationGroup *)groupAnimationForKey:(NSString *)groupKey{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = [self pathPointsForGroupKey:groupKey];
    animation.keyTimes = @[@(0),@(0.3),@(0.7),@(1)];
    
    //    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    CAKeyframeAnimation *scaleAnimation =  nil;
    if(![groupKey isEqualToString:@"avatar"]){
        scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:[self transfromFroFactor:0]],[NSValue valueWithCATransform3D:[self transfromFroFactor:.35]],[NSValue valueWithCATransform3D:[self transfromFroFactor:.45]],[NSValue valueWithCATransform3D:[self transfromFroFactor:1]]];
        scaleAnimation.keyTimes =@[@(0),@(0.3),@(0.7),@(1)];
        scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    }
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 4;
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
    if (scaleAnimation) {
        group.animations = @[animation,scaleAnimation];
    }else{
        group.animations = @[animation];
    }
    return group;
}

- (void)doCoreAnimation{
    CGPoint originalPoint = self.gifImgView.frame.origin;
    self.layer.anchorPoint = CGPointMake(0, 0);
    self.layer.position = originalPoint;

    CAAnimationGroup *group = [self groupAnimationForKey:nil];
    group.delegate = self;
    [self.layer addAnimation:group forKey:@"position and transform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.delegate respondsToSelector:@selector(ulAnimation:playFinished:)]) {
        [self.delegate ulAnimation:self playFinished:flag];
    }
    
    [self removeFromSuperview];
}

+ (CGFloat)scaleFactor{
    if (SMALLWIDTHSCALE) {
        return .8;
    }
    return  1.0/2 * 2;
}




@end
