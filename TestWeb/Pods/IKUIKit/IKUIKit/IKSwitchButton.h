//
//  SwitchButton.h
//
//
//  Created by 孙西纯 on 15/11/5.
//
//

#import <UIKit/UIKit.h>

typedef void (^IKSwitchActionBlock)(BOOL on);

@interface IKSwitchButton : UIButton

@property(nonatomic, assign) BOOL on;

- (void)setTitle:(NSString *)title;

- (void)setOnStateColor:(UIColor *)color;

- (void)setActionBlock:(IKSwitchActionBlock)block;

@end
