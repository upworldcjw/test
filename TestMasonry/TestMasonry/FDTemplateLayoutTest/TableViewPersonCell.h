//
//  TableViewPersonCell.h
//  TestMasonry
//
//  Created by jianwei on 10/28/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewPersonCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *imageV;

- (void)configView;
@end
