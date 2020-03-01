//
//  IKTLPersonalProtocol.h
//  inke
//
//  Created by JianweiChen on 2018/7/10.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#ifndef IKTLPersonalProtocol_h
#define IKTLPersonalProtocol_h

#import <UIKit/UIKit.h>

@protocol IKTLPersonalContentViewDelegate <NSObject>

- (void)contentView:(UIView *)contentView didSelected:(NSInteger)index;

- (void)contentViewEndScroll:(UIView *)contentView;

- (BOOL)isLivingForUid:(NSInteger)uid;

@end

@protocol IKTLPersonalContentViewDataSource <NSObject>

- (NSArray<id> *)dataSourceForContentView:(UIView *)contentView;

@end

@protocol IKTLPersonalInfoViewDelegate <NSObject>

- (void)personalInfoView:(UIView *)infoView needChangeHeight:(CGFloat)height;

@end

#endif /* IKTLPersonalProtocol_h */
