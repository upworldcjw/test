//
//  ShipView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationStarFallView.h"

@interface ULAnimationStarFallView()
@property (nonatomic,strong) UIImageView *starImgView;
@property (nonatomic,assign) CGPoint endPoint;
//@property (nonatomic,assign) CGFloat endScale;
@property (nonatomic,assign) CGFloat speedFactor;
@property (nonatomic,assign) CGFloat angle;
@property (nonatomic,strong) dispatch_block_t finished;
@end


@implementation ULAnimationStarFallView

- (instancetype)initWithFallType:(StarFallType)type finished:(dispatch_block_t)finished{
    NSArray *imageNameArr = @[@"snowStar_big",@"snowStar_middle",@"snowStar_small"];
    NSString *imageName = imageNameArr[type];

    if (self = [self initWithImageName:imageName]) {
        switch (type) {
            case StarFalBig:
                self.speedFactor = 1.4;
                break;
            case StarFalMiddle:
                self.speedFactor = 1.2;
                break;
            case StarFalSmall:
                self.speedFactor = 1;
                break;
            default:
                break;
        }
        self.finished = finished;
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName{
    UIImage *image = [self properSizeForImageName:imageName];
    if(self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)]){
        self.starImgView = [[UIImageView alloc] initWithImage:image];
        [self.starImgView setFrame:self.bounds];
        [self addSubview:self.starImgView];
        self.angle = 1.0/6*M_PI;
        self.userInteractionEnabled = NO;
        self.transform = CGAffineTransformMakeRotation(-self.angle);
    }
    return  self;
}

- (UIImage *)properSizeForImageName:(NSString *)imageName{
    if (imageName.length == 0) {
        imageName = @"snowStar_big";
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
    CGFloat x =  -self.frame.size.width;
    CGFloat y = self.beginPoint.y + tan(self.angle) * self.superview.frame.size.width;
    self.endPoint = CGPointMake(x, y);

    [self doAnimation];
}

- (CGPoint)middlePoint{
    return CGPointMake((self.beginPoint.x +self.endPoint.x)/2.0, (self.beginPoint.y + self.endPoint.y)/2.0);
}

- (void)doAnimation{
    __weak typeof(self) wself = self;
    [UIView animateKeyframesWithDuration:4/self.speedFactor delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        CGRect frame = self.frame;
        frame.origin = self.endPoint;
        self.frame = frame;
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:.5 animations:^{
            wself.alpha = 0;
        }];
    } completion:^(BOOL finished) {
        if (self.finished) {
            self.finished();
        }
    }];
}

@end
