//
//  PlaneView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationPlaneView.h"
#import "OLImageView.h"
#import "OLImage.h"

@interface ULAnimationPlaneView()

@property (nonatomic,strong) UIImageView *gifImgView;
@property (nonatomic,assign) CGPoint beginPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat endScale;

@end

@implementation ULAnimationPlaneView
-(void)dealloc{
    NSLog(@"ULAnimationPlaneView dealloc");
}

- (instancetype)initWithImageName:(NSString *)imageName{
    UIImage *image = [self properSizeForImageName:imageName];
    CGSize size = CGSizeMake(image.size.width/2.0 * [[self class] scaleFactor],image.size.height/2.0 * [[self class] scaleFactor]);
    if(self = [super initWithFrame:CGRectMake(0, 0, size.width ,size.height)]){
        OLImageView *gifImageView = [[OLImageView alloc] initWithImage:nil];
        gifImageView.image = image;
        self.gifImgView = gifImageView;
        [self.gifImgView setFrame:self.bounds];
        [self addSubview:gifImageView];
//        self.endScale = 1;
        self.endScale = .9/.5;
    }
    return  self;
}

- (UIImage *)properSizeForImageName:(NSString *)imageName{
    NSString *imagePath;
    if (imageName.length == 0) {
        imagePath = [[NSBundle mainBundle] pathForResource:@"bomber" ofType:@"gif"];
    }else{
        imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    }
    NSAssert(imagePath.length, @"image not exist");
    UIImage *image = [OLImage imageWithContentsOfFile:imagePath];
    return  image;
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
    point.x += 80 * [[self class] scaleFactor];
    point.y += 110 * [[self class] scaleFactor];
    return point;
}

- (void)animation{
    if (self.superview == nil) {
        NSAssert(NO, @"invoke after addsubview");
    }
    self.beginPoint = CGPointMake(-self.frame.size.width, 0.45 * self.superview.frame.size.height);
    //+ self.endScale * self.frame.size.width
    self.endPoint = CGPointMake(self.superview.frame.size.width, 0.25 * self.superview.frame.size.height);
    
    CGRect newFrame = self.frame;
    newFrame.origin = self.beginPoint;
    self.frame = newFrame;
    
    [self doCoreAnimation];
    [self doAvatarAnimationonView:self.superview setting:^(ULAvatarView *avatar) {
        avatar.transform = CGAffineTransformMakeRotation(-8.50/180 * M_PI);
    }];
}

- (CGFloat)scaleForFactor:(CGFloat)factor{
    CGFloat from3DScale = 1;
    CGFloat to3DScale = self.endScale;
    return (to3DScale - from3DScale)*factor + from3DScale;
}

- (CATransform3D)transfromFroFactor:(CGFloat)factor{
    CGFloat from3DScale = [self scaleForFactor:factor];
    return CATransform3DMakeScale(from3DScale, from3DScale, from3DScale);
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


- (CAAnimationGroup *)groupAnimationForKey:(NSString *)groupKey{
    //    *  kCAMediaTimingFunctionLinear            线性,即匀速
    //    *  kCAMediaTimingFunctionEaseIn            先慢后快
    //    *  kCAMediaTimingFunctionEaseOut           先快后慢
    //    *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
    //    *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = [self pathPointsForGroupKey:groupKey];
    animation.keyTimes = @[@(0),@(0.3),@(0.6),@(1)];

    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = 4;
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
    //    group.animations = @[animation,scaleAnimation];
    group.animations = @[animation];
    return  group;
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
        return  .8;
    }
    return  1.0/2 * 2;
}
@end

