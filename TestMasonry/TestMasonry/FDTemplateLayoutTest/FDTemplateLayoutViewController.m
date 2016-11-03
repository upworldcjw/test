//
//  ViewController.m
//  TestMasonry
//
//  Created by jianwei on 10/28/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "FDTemplateLayoutViewController.h"
#import "TableViewPersonCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <Masonry/Masonry.h>
@interface FDTemplateLayoutViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FDTemplateLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FDTemplateLayout";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[TableViewPersonCell class] forCellReuseIdentifier:@"TableViewPersonCell"];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TableViewPersonCell" configuration:^(TableViewPersonCell *cell) {
        cell.indexPath = indexPath;
        [cell configView];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewPersonCell *person = [tableView dequeueReusableCellWithIdentifier:@"TableViewPersonCell"];
    person.indexPath = indexPath;
    return person;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
