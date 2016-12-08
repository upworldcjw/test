//
//  ViewController.m
//  TestLabel
//
//  Created by JianweiChenJianwei on 2016/12/8.
//  Copyright © 2016年 UL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//13、adjustsLetterSpacingToFitWidth //改变字母

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*1. enabled只是决定了Label的绘制方式，将它设置.为NO将会使文本变暗，表示它没有激活，这时向它设置颜色值是无效的。
    */
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 40)];
        [self.view addSubview:label];
        label.text = @"hello!good";
        label.textColor = [UIColor blueColor];
        label.enabled = NO;
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    }

    
    /*2. baselineAdjustment 如果adjustsFontSizeToFitWidth属性设置为NO,这个属性就来控制文本基线的行为。label.baselineAdjustment = UIBaselineAdjustmentNone;UIBaselineAdjustmentAlignBaselines = 0,默认，文本最上端与中线对齐。UIBaselineAdjustmentAlignCenters,  文本中线与label中线对齐。UIBaselineAdjustmentNone, 文本最低端与label中线对齐。注意文本太长，需要shrink才会起作用

     */
    //参照，不起作用
    {
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentNone;
            label.adjustsFontSizeToFitWidth = YES;
        }
        {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 100, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            label.adjustsFontSizeToFitWidth = YES;
        }
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
            label.adjustsFontSizeToFitWidth = YES;
        }
    }
    //起作用
    {
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!goodhello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentNone;
            label.adjustsFontSizeToFitWidth = YES;
        }
        {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!goodhello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            label.adjustsFontSizeToFitWidth = YES;
        }
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 150, 100, 40)];
            [self.view addSubview:label];
            label.font = [UIFont systemFontOfSize:18];
            label.text = @"hello!goodhello!good";
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
            label.adjustsFontSizeToFitWidth = YES;
        }
    }
    
//    /*3. adjustsLetterSpacingToFitWidth 具体作用没测试出来
//     */
//    {
//        {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 60)];
//            [self.view addSubview:label];
//            label.lineBreakMode = NSLineBreakByCharWrapping;
//            label.numberOfLines = 2;
//            label.font = [UIFont systemFontOfSize:18];
//            label.text = @"Very!goodVery!good";
//            label.textColor = [UIColor blueColor];
//            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
////            label.adjustsLetterSpacingToFitWidth = YES;
//            label.allowsDefaultTighteningForTruncation = YES;
//        }
//        {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 200, 100, 60)];
//            [self.view addSubview:label];
//            label.numberOfLines = 2;
//            label.lineBreakMode = NSLineBreakByCharWrapping;
//            label.font = [UIFont systemFontOfSize:18];
//            label.text = @"Very!goodVery!good";
//            label.textColor = [UIColor blueColor];
//            label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
////            label.adjustsLetterSpacingToFitWidth = NO;
//            label.allowsDefaultTighteningForTruncation = NO;
//
//        }
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
