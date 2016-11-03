//
//  TableViewPersonCell.m
//  TestMasonry
//
//  Created by jianwei on 10/28/16.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "TableViewPersonCell.h"
#import <Masonry/Masonry.h>
@interface TableViewPersonCell()

@end

@implementation TableViewPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        self.imageV.backgroundColor = [UIColor redColor];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.equalTo(@(80)).priority(10);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        UILabel *lable = [UILabel new];
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView);
            make.left.equalTo(self);
        }];
        lable.text = @"UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.";
    }
    return self;
}


- (void)updateConstraints
{
    [super updateConstraints];
    NSLog(@"updateConstraints");
}

- (void)configView{
    [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.indexPath.row % 2 == 0) {
            make.height.equalTo(@(300));
        } else {
            make.height.equalTo(@(10));
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
