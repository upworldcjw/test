//
//  ViewController.m
//  TestFont
//
//  Created by JianweiChen on 2017/5/3.
//  Copyright © 2017年 IK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *positionImageV;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIFont *font = [UIFont systemFontOfSize:40];
  UILabel *label = [UILabel new];
  label.font = font;
  label.text = @"123";
  label.frame = CGRectMake(20, 60, 20, 30);
  label.backgroundColor = [UIColor redColor];
  [self.view addSubview:label];
  self.positionImageV = label;
  
  UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  pauseBtn.backgroundColor = [UIColor redColor];
  [pauseBtn setTitle:@"pause" forState:UIControlStateNormal];
  [self.view addSubview:pauseBtn];
  pauseBtn.frame = CGRectMake(0, 20, 40, 40);
  [pauseBtn addTarget:self action:@selector(pauseBtnTouch) forControlEvents:UIControlEventTouchUpInside];
  
  
  UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  playBtn.backgroundColor = [UIColor redColor];
  [playBtn setTitle:@"play" forState:UIControlStateNormal];
  [self.view addSubview:playBtn];
  playBtn.frame = CGRectMake(80, 20, 40, 40);
  [playBtn addTarget:self action:@selector(playBtnBtnTouch) forControlEvents:UIControlEventTouchUpInside];
  
  //位移动画
  CABasicAnimation * positionAnim = [CABasicAnimation animation];
  positionAnim.keyPath = @"position";
  positionAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.positionImageV.center.x+200, self.positionImageV.center.y)];
  // 设置动画执行次数
  positionAnim.repeatCount = MAXFLOAT;
  // 取消动画反弹
  // 设置动画完成的时候不要移除动画
  positionAnim.removedOnCompletion = NO;
  // 设置动画执行完成要保持最新的效果
  positionAnim.fillMode = kCAFillModeForwards;
  positionAnim.duration = 10;
//  positionAnim.beginTime = CACurrentMediaTime();
  [self.positionImageV.layer addAnimation:positionAnim forKey:nil];
}

- (void)pauseBtnTouch{
  CALayer *layer = self.positionImageV.layer;
  CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
  NSLog(@"pausedTime %f",pausedTime);
  // 让CALayer的时间停止走动
  layer.speed = 0.0;
  // 让CALayer的时间停留在pausedTime这个时刻
//  layer.timeOffset = pausedTime;
  

}

- (void)playBtnBtnTouch{
  CALayer *layer = self.positionImageV.layer;
  NSLog(@"beginTime = %f, timeOffset = %f, speed = %f",layer.beginTime,layer.timeOffset,layer.speed);
  if (layer.speed != 0) {
    return;
  }
  
//  CFTimeInterval pausedTime = layer.timeOffset;
//  // 1. 让CALayer的时间继续行走
//  layer.speed = 1.0;
//  // 2. 取消上次记录的停留时刻
//  layer.timeOffset = 0.0;
//  // 3. 取消上次设置的时间
//  layer.beginTime = 0.0;
//  // 4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
//  CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//  // 5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
//  layer.beginTime = timeSincePause;
//  
//  NSLog(@"timeSincePause %f",timeSincePause);
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
