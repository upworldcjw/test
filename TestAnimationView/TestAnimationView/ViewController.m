//
//  ViewController.m
//  TestAnimationView
//
//  Created by jianwei.chen on 16/4/20.
//  Copyright © 2016年 jianwei.chen. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCar.h"
#import "ViewControllerShip.h"
#import "ViewControllerSnow.h"
#import "ViewControllerFire.h"
#import "ViewControllerPlane.h"
#import "ViewControllerTower.h"
@interface ViewController (){
    NSArray *_arr;
}

@end

@implementation ViewController{
    UIView *_testView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = @[NSStringFromClass([ViewControllerShip class]),
                     NSStringFromClass([ViewControllerCar class]),
                     NSStringFromClass([ViewControllerSnow class]),
                     NSStringFromClass([ViewControllerFire class]),
                     NSStringFromClass([ViewControllerPlane class]),
                     NSStringFromClass([ViewControllerTower class])
                     ];
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat margin = 5;
    
    
    NSInteger  maxY = self.view.frame.size.height/(height + margin);
    NSInteger maxX = self.view.frame.size.width/(width + margin);
    
//    maxY = _arr.count/maxX;
    //    NSInteger y = x = 0;
    for (int y=0; y<maxY; y++) {
        for (int x=0; x<maxX; x++) {
            
            NSInteger i = y*maxX+x;
            if (i >= _arr.count) {
                goto label;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat xPoint = x * (width + margin);
            CGFloat yPoint = y * (height + margin);
            button.frame = CGRectMake(xPoint, yPoint, width, height);
            [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor grayColor];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.titleLabel.textColor = [UIColor whiteColor];
            [button setTitle:[_arr[i] substringFromIndex:14] forState:UIControlStateNormal];
            button.tag = i;
            [self.view addSubview:button];
        }
    }
    
label:{
    
}
    CGPoint center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.view addSubview:hView];
    hView.center = center;
    hView.backgroundColor = [UIColor redColor];
    
    UIView *vView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,1, self.view.frame.size.height)];
    [self.view addSubview:vView];
    vView.center = center;
    vView.backgroundColor = [UIColor redColor];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectZero];
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(100, 100);
    testView.frame = rect;
    testView.layer.anchorPoint = CGPointMake(0, 0);
    testView.layer.position = center;
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor blueColor];
    _testView = testView;
    
    UISlider *slider= [[UISlider alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width - 100, 40)];
    slider.minimumValue = 0;
    slider.maximumValue = 3;
    slider.value = 1;
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)test:(UISlider *)slider{
    _testView.layer.transform = CATransform3DMakeScale(slider.value, slider.value, slider.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)touch:(UIButton *)button{
    
    UIViewController *vc = [[NSClassFromString(_arr[button.tag]) alloc] init];
    [self presentViewController:vc animated:YES completion:NULL];
}

@end
