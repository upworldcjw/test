//
//  ViewControllerA.m
//  TestPresent
//
//  Created by JianweiChen on 2018/2/12.
//  Copyright © 2018年 inke. All rights reserved.
//

#import "ViewControllerA.h"
#import "ViewControllerC.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor greenColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ViewControllerC *vc = [[ViewControllerC alloc] init];
        [self presentViewController:vc animated:YES completion:NO];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
