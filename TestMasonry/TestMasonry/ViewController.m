//
//  ViewController.m
//  TestMasonry
//
//  Created by jianwei on 10/28/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"
#import "FDTemplateLayoutViewController.h"
#import "ScrollViewController.h"
#import <Masonry/Masonry.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test Constraints";
    self.arr = @[NSStringFromClass([FDTemplateLayoutViewController class]),
                 NSStringFromClass([ScrollViewController class])
                 ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(-20));
    }];
    tableView.backgroundColor = [UIColor blueColor];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:@"UITableViewCell" configuration:^(TableViewPersonCell *cell) {
//        cell.indexPath = indexPath;
//        [cell configView];
//    }];
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *person = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    person.textLabel.text = self.arr[indexPath.row];
    return person;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.arr[indexPath.row];
    id vc = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
