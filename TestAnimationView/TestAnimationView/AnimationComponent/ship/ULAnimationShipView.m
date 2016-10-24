//
//  ShipView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationShipView.h"
#import "ULAvatarView.h"
@interface ULAnimationShipView()
@property (nonatomic,strong) UIImageView *seaBgImgView;
@property (nonatomic,strong) UIImageView *seaBgImgView2;
@property (nonatomic,strong) UIImageView *shipImgVeiw;
@property (nonatomic,assign) CGFloat seaH;
@property (nonatomic,assign) CGFloat seaBgWidth;
@property (nonatomic,assign) CGFloat offsetX;

@property (nonatomic,assign) CGPoint beginPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat endScale;
@end


@implementation ULAnimationShipView

-(void)dealloc{
    NSLog(@"ULAnimationShipView dealloc");
}

- (instancetype)initWithImageName:(NSString *)imageName{
    UIImage *image = [self properSizeForImageName:imageName];
    CGFloat height = [UIImage imageNamed:[[self class] seaImgName]].size.height + image.size.height * [[self class] scaleFactor];
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    if (self = [super initWithFrame:CGRectMake(0, 0, width, height)]) {
        self.seaH = 30; //动画左右移动距离
        self.offsetX = 30;//刚初始化的时候显示波浪向左偏离
        [self createBgView];
        
        self.shipImgVeiw = [[UIImageView alloc] initWithImage:nil];
        CGRect newFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        newFrame.size.width *= [[self class] scaleFactor];
        newFrame.size.height *= [[self class] scaleFactor];
        newFrame.origin.y = 40;
        newFrame.origin.x = - newFrame.size.width;
        self.shipImgVeiw.frame = newFrame;
        [self addSubview:self.shipImgVeiw];
        
//        CALayer *layer = [CALayer layer];
//        layer.backgroundColor = [UIColor colorWithWhite:.5 alpha:1].CGColor;
//        UIImage *shipshoadowImg = [UIImage imageNamed:@"shipshadow"];
//        layer.contents = (__bridge id _Nullable)(shipshoadowImg.CGImage);
//        [self.shipImgVeiw.layer addSublayer:layer];
        
        CALayer *shipLayer = [CALayer layer];
        shipLayer.backgroundColor = [UIColor clearColor].CGColor;
        shipLayer.contents = (__bridge id _Nullable)(image.CGImage);
        shipLayer.frame = self.shipImgVeiw.bounds;
        [self.shipImgVeiw.layer addSublayer:shipLayer];
        
//        newFrame = CGRectMake(0, 0, shipshoadowImg.size.width, shipshoadowImg.size.height);
//        newFrame.size.width *= [[self class] scaleFactor] *.95;
//        newFrame.size.height *= [[self class] scaleFactor] *.95;
//        newFrame.origin.y += (self.shipImgVeiw.frame.origin.y + 40) * [[self class] scaleFactor];
//        newFrame.origin.x = -5;
//        layer.frame = newFrame;
        //调整船头方向
//        self.shipImgVeiw.transform = CGAffineTransformMakeRotation(sqrt(3)/4);
        self.endScale = 1 * 0.9/0.5;
        self.userInteractionEnabled = NO;
        self.hidden = YES;
    }
    return self;
}

- (UIImage *)properSizeForImageName:(NSString *)imageName{
    if (imageName.length == 0) {
        imageName = @"ship";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    return  image;
}

- (void)createBgView{
    self.seaBgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[self class] seaImgName]]];
    [self addSubview:self.seaBgImgView];
    self.seaBgImgView.alpha = .5;
    
    self.seaBgImgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[self class] seaImgName]]];
    [self addSubview:self.seaBgImgView2];
}


- (CGFloat)maxOffsetX{
    CGFloat offsetX = self.seaBgWidth - (self.frame.size.width + self.offsetX);
    return - offsetX;
}

- (CGFloat)minOffsetX{
    return - self.offsetX;
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
    point.x += 0;
    point.y += (self.shipImgVeiw.frame.size.height* (self.endScale -1))/2 * parm;
    if (SMALLWIDTHSCALE){
        point.y += -6;
    }
    return point;
}

- (void)configSubViews{
    //修改自己的frame
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height - self.frame.size.height + 30;//下部图片偏白下移动30
    self.frame = frame;
    //修改波浪背景的frame
    CGRect newFrame = self.seaBgImgView.frame;
    newFrame.origin.y = self.frame.size.height - self.seaBgImgView.frame.size.height;
    newFrame.origin.x = [self minOffsetX];
    self.seaBgImgView.frame = newFrame;
    self.seaBgWidth = self.seaBgImgView.frame.size.width;
    
    //修改波浪2背景的frame
    newFrame = self.seaBgImgView2.frame;
    newFrame.origin.y = self.frame.size.height - self.seaBgImgView2.frame.size.height;
    newFrame.origin.y += 25;
    newFrame.origin.x = [self maxOffsetX];
    self.seaBgImgView2.frame = newFrame;
}



- (void)animation{
    if (self.superview == nil) {
        NSAssert(NO, @"invoke after addsubview");
    }
    self.hidden = NO;
    [self configSubViews];
    self.beginPoint = self.shipImgVeiw.frame.origin;
    CGFloat originalY = self.shipImgVeiw.frame.origin.y;
    
    //船水平运行
//    self.endPoint = CGPointMake(self.superview.frame.size.width + 0 * self.shipImgVeiw.frame.size.width, originalY - (self.endScale*.8 -1)*self.shipImgVeiw.frame.size.height);
    //船右下偏移
    self.endPoint = CGPointMake(self.superview.frame.size.width + 0 * self.shipImgVeiw.frame.size.width, originalY+50);
    
    [self seaAnimation];
    [self shipCoreAnimation];
    [self doAvatarAnimationonView:self setting:^(ULAvatarView *avatarView) {
//        avatarView.layer.anchorPoint = CGPointMake(0, 0.5);
        avatarView.layer.position = [self avatarPointForRelative:0];
    }];
}


- (void)seaAnimation{
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGFloat maxOffset = self.seaBgImgView.frame.size.width - self.superview.frame.size.width + [self minOffsetX];
        maxOffset -= 20;
        
        CGRect newFrame = wself.seaBgImgView.frame;
        newFrame.origin.x = [wself minOffsetX] - maxOffset;//左右移动
        wself.seaBgImgView.frame = newFrame;
        
        newFrame = self.seaBgImgView2.frame;
        newFrame.origin.x = [wself maxOffsetX] + maxOffset;
        wself.seaBgImgView2.frame = newFrame;
        
    } completion:^(BOOL finished) {
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

- (NSArray *)keyTimesForGroupKey:(NSString *)groupKey{
    return  @[@(0),@(0.4),@(0.75),@(1)];
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
    
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    CAKeyframeAnimation *scaleAnimation = nil;
    if (![groupKey isEqualToString:@"avatar"]) {
        scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:[self transfromFroFactor:0]],[NSValue valueWithCATransform3D:[self transfromFroFactor:.45]],[NSValue valueWithCATransform3D:[self transfromFroFactor:.55]],[NSValue valueWithCATransform3D:[self transfromFroFactor:1]]];
        scaleAnimation.keyTimes =@[@(0),@(0.4),@(0.75),@(1)];
        scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    }
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 6;
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
    if (scaleAnimation) {
        group.animations = @[animation,scaleAnimation];
    }else{
        group.animations = @[animation];
    }
    return group;
}

- (void)shipCoreAnimation{
    CGPoint originalPoint = self.shipImgVeiw.frame.origin;
    self.shipImgVeiw.layer.anchorPoint = CGPointMake(0, 0);
    self.shipImgVeiw.layer.position = originalPoint;
    
    CAAnimationGroup *group = [self groupAnimationForKey:nil];
    group.delegate = self;
    [self.shipImgVeiw.layer addAnimation:group forKey:@"position and transform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.delegate respondsToSelector:@selector(ulAnimation:playFinished:)]) {
        [self.delegate ulAnimation:self playFinished:flag];
    }
    [self removeFromSuperview];
}

+ (NSString *)seaImgName{
    return @"sea";
}

+ (CGFloat)scaleFactor{
    if (SMALLWIDTHSCALE){
        return 2.0/5 * 2 * 0.8;
    }
    return 2.0/5 * 2;
}

@end
