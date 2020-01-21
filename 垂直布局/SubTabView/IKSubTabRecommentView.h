//
//  IKSubDynamicTabView.h
//  inke
//
//  Created by Vincent on 2018/5/4.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKSubDynamicTabModel.h"
#import "IKSubTabFlowLayout.h"

@protocol IKSubTabRecommentViewDelegate <NSObject>

- (void)clickSubTab:(IKSubDynamicTabModel *)tabModel;

@end

@interface IKSubTabRecommentView : UIView

@property (nonatomic, weak)id<IKSubTabRecommentViewDelegate> delegate;

+ (CGFloat)properHeight;

- (void)reloadData:(NSArray<IKSubDynamicTabModel *> *)tabDataArray;

@end
