//
//  FireView.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/21.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ULAnimationFireView.h"
#import "OLImageView.h"
#import "OLImage.h"
#import "DDImageView.h"

//第几轮烟花
@interface FirePlayCycleItem : NSObject
@property (nonatomic ,strong) NSArray *imgs;//图片
@property (nonatomic, strong) NSArray *points;//点
@end

@implementation FirePlayCycleItem
- (NSInteger)count{
    return [_imgs count];
}
@end


@interface ULAnimationFireItemVeiw : UIImageView
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,assign) CGPoint playAtPoint;

+(instancetype)itemViewAtPoint:(CGPoint)point withImage:(UIImage *)image;
@end

//不支持重用
@implementation ULAnimationFireItemVeiw

-(instancetype)initWithPoint:(CGPoint)point image:(UIImage *)image{
    CGSize size = CGSizeMake(image.size.width/2.0 * [ULAnimationFireItemVeiw scaleFactor],image.size.height/2.0 * [ULAnimationFireItemVeiw scaleFactor]);
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
    ULAnimationFireItemVeiw *itemView = [[ULAnimationFireItemVeiw alloc] initWithPoint:point image:image];
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
    if(SPECIALSCALE){
        return  1.0/2;
    }
    return 1;
}
@end

@interface ULAnimationFireView()
@property (nonatomic,strong) DDImageView *beginFiresView;
@property (nonatomic,strong) NSArray *firesImgNames;
@property (nonatomic,strong) NSArray *points;
@property (nonatomic, strong) NSMutableArray<FirePlayCycleItem *> *cycleItems;

@property (nonatomic,assign)  NSInteger hadPlayCount;
@property (nonatomic,assign) NSInteger allCount;

@end

@implementation ULAnimationFireView

-(void)dealloc{
    NSLog(@"ULAnimationFireView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled  = NO;
        self.cycleItems = [NSMutableArray arrayWithCapacity:3];
    }
    return  self;
}

- (CGPoint)beginPoint{
    CGFloat x = self.frame.size.width * .3;
    CGFloat y = self.frame.size.height - [self beginSize].height - 50;
    return  CGPointMake(x, y);
}

//firework_launch1 决定
- (CGSize)beginSize{
    return CGSizeMake(369/2.0, 493/2.0);
}

- (DDImageView *)beginFiresView{
    if (_beginFiresView == nil) {
        CGRect newFrame = CGRectZero;
        newFrame.size = [self beginSize];
        newFrame.origin = [self beginPoint];
        
        _beginFiresView = [[DDImageView alloc] initWithFrame:newFrame];
        NSMutableArray *imgs = [NSMutableArray arrayWithCapacity:10];
        for (int i = 1; i < 11; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"firework_launch%d",i]];
            [imgs addObject:image];
        }
        _beginFiresView.animationImages = imgs;
        _beginFiresView.animationRepeatCount = 1;
//        _beginFiresView.frame = newFrame;
    }
    return _beginFiresView;
}

- (void)animation{
    NSAssert(self.superview, @"should add to superview");
    
    CGFloat time = .5;
    CGFloat timeInterval = 60.0 * (time/[self.beginFiresView.animationImages count]);
    self.beginFiresView.animationDuration = time;
    [self.beginFiresView setAnimationInterval:timeInterval];
    [self addSubview:self.beginFiresView];
    [self.beginFiresView startAnimating];
    
    __weak typeof(self) wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wself loadFiresImgViews];
        
        [UIView animateWithDuration:1 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            self.beginFiresView.alpha = 0;
        } completion:^(BOOL finished) {
            //移除减小内存占用
            [wself.beginFiresView removeFromSuperview];
            wself.beginFiresView = nil;
        }];
    });
    
    ULAvatarView *avatarView = [[ULAvatarView alloc] initWithImgSize:CGSizeMake(30, 30) andName:self.name?self.name:@"Name"];
    [self addSubview:avatarView];
    CGRect frame = avatarView.frame;
    frame.origin.x = self.frame.size.width - avatarView.frame.size.width -20;
    frame.origin.y = self.beginFiresView.frame.origin.y + self.beginFiresView.frame.size.height - 50;
    avatarView.frame =  frame;
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
    NSArray *colors = @[@"brown",@"blue",@"orange",@"red"];
    self.firesImgNames = colors;
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(.2, .3)],
                        [NSValue valueWithCGPoint:CGPointMake(.3, .4)],
                        [NSValue valueWithCGPoint:CGPointMake(.5, .5)],
                        [NSValue valueWithCGPoint:CGPointMake(.7, .3)]];
    
    NSMutableArray *realPoints = [NSMutableArray arrayWithCapacity:[points count]];
    for (NSValue *relativePoint in points) {
        CGPoint original = [relativePoint CGPointValue];
        CGPoint point = CGPointMake(original.x * self.frame.size.width, original.y * self.frame.size.height);
        [realPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    self.points = realPoints;

    NSInteger cycle = 3;
    for (int i = 0; i < cycle; i++) {
        FirePlayCycleItem *item = [[FirePlayCycleItem alloc] init];
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
    for (FirePlayCycleItem *item in self.cycleItems) {
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
        [self playFinished];
    }
}


- (void)playAtPoint:(CGPoint)point withImage:(UIImage *)image{
    NSLog(@"%@",NSStringFromCGPoint(point));
    __weak typeof(self) wself = self;
    ULAnimationFireItemVeiw *itemView = [ULAnimationFireItemVeiw itemViewAtPoint:point withImage:image];
    [self addSubview:itemView];
    [itemView play:^(BOOL finished) {
        wself.hadPlayCount += 1;
    }];
}

+ (CGFloat)scaleFactor{
    return [UIScreen mainScreen].bounds.size.width/750;
    //    return 1;
}

@end

