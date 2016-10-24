//
//  FireView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationTowerView.h"
#import "OLImageView.h"
#import "OLImage.h"
#import "DDImageView.h"

//第几轮烟花
@interface TowerFirePlayCycleItem : NSObject
@property (nonatomic ,strong) NSArray *imgs;//图片
@property (nonatomic, strong) NSArray *points;//点
@end

@implementation TowerFirePlayCycleItem
- (NSInteger)count{
    return [_imgs count];
}
@end


@interface TowerULAnimationFireItemVeiw : UIImageView
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,assign) CGPoint playAtPoint;

+(instancetype)itemViewAtPoint:(CGPoint)point withImage:(UIImage *)image;
@end

//不支持重用
@implementation TowerULAnimationFireItemVeiw

-(instancetype)initWithPoint:(CGPoint)point image:(UIImage *)image{
    CGSize size = CGSizeMake(image.size.width/2.0 * [TowerULAnimationFireItemVeiw scaleFactor],image.size.height/2.0 * [TowerULAnimationFireItemVeiw scaleFactor]);
    if (self = [super initWithImage:image]) {
        self.isPlaying = NO;
        self.playAtPoint = point;
        CGRect frame = self.frame;
        frame.size = size;
        
        self.frame = frame;
        self.center = point;
        self.transform = CGAffineTransformMakeScale(.0, .0);
    }
    return self;
}

+(instancetype)itemViewAtPoint:(CGPoint)point withImage:(UIImage *)image{
    TowerULAnimationFireItemVeiw *itemView = [[TowerULAnimationFireItemVeiw alloc] initWithPoint:point image:image];
    return  itemView;
}

- (void)play:(void(^)(BOOL finished))finish{
    __weak typeof(self) wself = self;
    self.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        wself.transform = CGAffineTransformMakeScale(2.5,2.5);
        wself.alpha = 0;
    } completion:^(BOOL finished) {
        finish(finished);
        [wself removeFromSuperview]; //播放完之后移除
    }];
}

+ (CGFloat)scaleFactor{
    if (SPECIALSCALE) {
        return 1.0/2.0;
    }
    return 1;
}
@end



@interface ULAnimationTowerView()
@property (nonatomic,strong) UIImageView *starImgView;
@property (nonatomic,strong) UIImageView *towerImgView;
@property (nonatomic,strong) UIImageView *bgSnowImgView;
@property (nonatomic,strong) UIImageView *forentSnowImgView;

@property (nonatomic,strong) NSArray *firesImgNames;
@property (nonatomic,strong) NSArray *points;
@property (nonatomic, strong) NSMutableArray<TowerFirePlayCycleItem *> *cycleItems;

@property (nonatomic,assign)  NSInteger hadPlayCount;
@property (nonatomic,assign) NSInteger allCount;
@end


@implementation ULAnimationTowerView

- (void)dealloc{
    NSLog(@"ULAnimationTowerView dealloc");
}

- (void)scaleView:(UIView *)view factor:(CGFloat)factor{
    CGRect frame = view.frame;
    frame.size.width *= factor;
    frame.size.height *= factor;
    view.frame = frame;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled  = NO;
        
        self.starImgView = [self getImageViewWithName:@"castle_star"];
        [self addSubview:self.starImgView];
        [self scaleView:self.starImgView factor:.5];
        
        self.bgSnowImgView = [self getImageViewWithName:@"cloud_behind"];
        [self addSubview:self.bgSnowImgView];
        [self scaleView:self.bgSnowImgView factor:.5];
        
        self.towerImgView = [self getImageViewWithName:@"castle"];
        [self addSubview:self.towerImgView];
        [self scaleView:self.towerImgView factor:.85];
        
        self.forentSnowImgView = [self getImageViewWithName:@"cloud_ahead"];
        [self addSubview:self.forentSnowImgView];
        [self scaleView:self.forentSnowImgView factor:.5];
    }
    return  self;
}

- (UIImageView *)getImageViewWithName:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imgView.layer.anchorPoint = CGPointMake(.5, 1);
    imgView.layer.position = CGPointZero;
    
    return imgView;
}

- (CGFloat)heightFactor:(CGFloat)factor{
    return self.frame.size.height * factor;
}

- (CGFloat)widthFactor:(CGFloat)factor{
    return self.frame.size.width * factor;
}

- (void)animation{
    NSAssert(self.superview, @"should add to superview");
    self.frame = self.superview.bounds;
    
    CGRect starRect= CGRectZero;
    starRect.origin.x = 0;
    
    CGFloat factor = self.frame.size.width / self.starImgView.frame.size.width;
    starRect.size.width =   [self widthFactor:1.0];
    starRect.size.height  = factor * self.starImgView.frame.size.height;
    self.starImgView.frame = starRect;
    
    self.starImgView.layer.position = CGPointMake([self widthFactor:.5], [self heightFactor:.7]);
    CGRect towerRect = self.towerImgView.frame;
    factor = 1.3;
    towerRect.size.height *= factor;
    towerRect.size.width *= factor;
    self.towerImgView.frame = towerRect;
    self.towerImgView.layer.position = CGPointMake([self widthFactor:.5], [self heightFactor:.7]);
    self.bgSnowImgView.layer.position = CGPointMake([self widthFactor:.5], [self heightFactor:.7]);
    self.forentSnowImgView.layer.position = CGPointMake([self widthFactor:.5], [self heightFactor:.75]);
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:6
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                         CGRect rect = wself.bgSnowImgView.frame;
                         rect.origin.x += -80;
                         wself.bgSnowImgView.frame = rect;
                         
                         rect = wself.forentSnowImgView.frame;
                         rect.origin.x += 80;
                         wself.forentSnowImgView.frame =rect;
                         
                     } completion:^(BOOL finished) {
                         [wself playFinished];
//                         [wself removeFromSuperview];
                     }];
    
    
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationRepeatCount:HUGE_VALF];
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        wself.starImgView.alpha = 0.1;
    }];
    
    [self loadFiresImgViews];
    
    ULAvatarView *avatarView = [[ULAvatarView alloc] initWithImgSize:CGSizeMake(30, 30) andName:self.name?self.name:@"Name"];
    [self addSubview:avatarView];
    CGFloat height = self.forentSnowImgView.frame.origin.y + self.forentSnowImgView.frame.size.height;
    avatarView.center = CGPointMake(self.frame.size.width/2.0, height + 20);
}

- (NSArray *)unRepeatRandoumArr:(NSArray *)originalArr{
    NSInteger count = [originalArr count];
    
    NSMutableArray *randomPoints = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *originalCopy = [originalArr mutableCopy];
    for (NSInteger i=0; i<count; i++) {
       
        while ([originalCopy count] > 0) {
            NSUInteger i = arc4random() % [originalCopy count];
            [randomPoints addObject:originalCopy[i]];
            [originalCopy removeObjectAtIndex:i];
            count ++;
        }
    }
    return randomPoints;
}

- (NSArray *)fireImgs{
    NSArray *colors = self.firesImgNames;
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:[colors count]];
    for (NSInteger i = 0; i < [colors count]; i++) {
        [mutArr addObject:[UIImage imageNamed:colors[i]]];
    }
    return  mutArr;
}

- (void)loadFiresImgViews{
    self.cycleItems = [NSMutableArray array];
    NSArray *colors = @[@"brown",@"blue",@"orange",@"red"];
    self.firesImgNames = colors;
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(.2, .2)],
                        [NSValue valueWithCGPoint:CGPointMake(.3, .3)],
                        [NSValue valueWithCGPoint:CGPointMake(.5, .4)],
                        [NSValue valueWithCGPoint:CGPointMake(.7, .2)]];
    
    NSMutableArray *realPoints = [NSMutableArray arrayWithCapacity:[points count]];
    for (NSValue *relativePoint in points) {
        CGPoint original = [relativePoint CGPointValue];
        CGPoint point = CGPointMake(original.x * self.frame.size.width, original.y * self.frame.size.height);
        [realPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    self.points = realPoints;

    NSInteger cycle = 5;
    for (int i = 0; i < cycle; i++) {
        TowerFirePlayCycleItem *item = [[TowerFirePlayCycleItem alloc] init];
        item.points = [self unRepeatRandoumArr:self.points];
        item.imgs = [self unRepeatRandoumArr:[self fireImgs]];
        [self.cycleItems addObject:item];
    }
    [self playFire];
}

- (void)playFire{
    NSInteger count = 0;
    CGFloat timeInterval = 0.25;
    __weak typeof(self) wself = self;
    for (TowerFirePlayCycleItem *item in self.cycleItems) {
        for (NSInteger i= 0; i< [item count]; i++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(count * timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%f",count * timeInterval);
                [wself playAtPoint:[item.points[i] CGPointValue] withImage:item.imgs[i]];
            });
            count ++;
        }
    }
    self.allCount = count;
}

- (void)playFinished{
    if ([self.delegate respondsToSelector:@selector(ulAnimation:playFinished:)]) {
        [self.delegate ulAnimation:self playFinished:YES];
    }
    [self removeFromSuperview];
}

- (void)setHadPlayCount:(NSInteger)hadPlayCount{
    _hadPlayCount = hadPlayCount;
    if (hadPlayCount >= self.allCount) {
//        [self playFinished];
    }
}

- (void)playAtPoint:(CGPoint)point withImage:(UIImage *)image{
    NSLog(@"%@",NSStringFromCGPoint(point));
    __weak typeof(self) wself = self;
    TowerULAnimationFireItemVeiw *itemView = [TowerULAnimationFireItemVeiw itemViewAtPoint:point withImage:image];
    [self insertSubview:itemView belowSubview:self.starImgView];
    [itemView play:^(BOOL finished) {
        wself.hadPlayCount += 1;
    }];
}

+ (CGFloat)scaleFactor{
    return 1.0/2.0;
}

@end

