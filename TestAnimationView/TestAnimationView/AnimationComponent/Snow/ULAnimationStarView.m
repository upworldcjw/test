//
//  ShipView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationStarView.h"

@interface ULAnimationStarView()
@property (nonatomic,strong) UIImageView *starImgView;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat speedFactor;
@property (nonatomic,assign) CGFloat angle;
@property (nonatomic,strong) dispatch_block_t finished;
@end


@implementation ULAnimationStarView
- (instancetype)initWithImageName:(NSString *)imageName finished:(dispatch_block_t)finished{
    UIImage *image = [self properSizeForImageName:imageName];
    if(self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)]){
        self.starImgView = [[UIImageView alloc] initWithImage:image];
        [self.starImgView setFrame:self.bounds];
        [self addSubview:self.starImgView];
//        self.layer.anchorPoint = CGPointMake(0, 0);
        self.angle = 1.0/6 * M_PI;
        self.speedFactor = 1;
        self.userInteractionEnabled = NO;
        self.finished = finished;
    }
    return  self;
}

- (UIImage *)properSizeForImageName:(NSString *)imageName{
    if (imageName.length == 0) {
        imageName = @"star";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    return  image;
}

- (void)setBeginPoint:(CGPoint)beginPoint{
    _beginPoint = beginPoint;
    CGRect frame = self.frame;
    frame.origin = _beginPoint;
    self.frame = frame;
//    self.layer.position = self.beginPoint;
}

- (void)animation{
    if (self.superview == nil) {
        NSAssert(NO, @"invoke after addsubview");
    }
    
    CGFloat x = -self.frame.size.width;
    CGFloat y = self.beginPoint.y + tan(self.angle) * self.superview.frame.size.width;
    self.endPoint = CGPointMake(x, y);

    [self doAnimation];
}

- (void)doAnimation{
    __weak typeof(self) wself = self;
    CGFloat factorBegin = (arc4random() * 1.0)/UINT32_MAX;
    CGFloat factor = (arc4random() * 1.0)/UINT32_MAX;
    self.alpha = factorBegin;
    [UIView animateWithDuration:1.5 animations:^{
        [UIView setAnimationRepeatCount:HUGE_VALF];
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        wself.alpha = factor;
    }];
    
    [UIView animateWithDuration:4 animations:^{
        CGRect frame = self.frame;
        frame.origin = self.endPoint;
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        if (self.finished) {
            self.finished();
        }
    }];
}

//- (void)shipAnimation2{
//    //    *  kCAMediaTimingFunctionLinear            线性,即匀速
//    //    *  kCAMediaTimingFunctionEaseIn            先慢后快
//    //    *  kCAMediaTimingFunctionEaseOut           先快后慢
//    //    *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
//    //    *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.values = @[[NSValue valueWithCGPoint:[self pointForRelative:.0]],[NSValue valueWithCGPoint:[self pointForRelative:.5]],[NSValue valueWithCGPoint:[self pointForRelative:.6]],[NSValue valueWithCGPoint:[self pointForRelative:1]]];
//    animation.keyTimes = @[@(0),@(0.4),@(0.7),@(1)];
//    
//    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    
//    ////    //图像由大到小的变化动画
//    CGFloat from3DScale = 1;
//    CGFloat to3DScale = self.endScale;
//    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
//    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    
//    ////////////////////////////////////////////////////////////////////////////////////////////
//    //动画组合
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.delegate = self;
//    group.duration = 4;
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
//    group.animations = @[animation,scaleAnimation];
//    [self.shipImgVeiw.layer addAnimation:group forKey:@"position and transform"];
//}
//
//- (CGPoint)pointForRelative:(CGFloat)parm{
//    CGFloat dy = self.endPoint.y - self.beginPoint.y;
//    CGFloat dx = self.endPoint.x - self.beginPoint.x;
//    CGFloat x = self.beginPoint.x + dx * parm;
//    CGFloat y = self.beginPoint.y + dy * parm;
//    
//    CGPoint point = CGPointMake(x, y);
//    NSLog(@"%@",NSStringFromCGPoint(point));
//    return point;
//}
@end
