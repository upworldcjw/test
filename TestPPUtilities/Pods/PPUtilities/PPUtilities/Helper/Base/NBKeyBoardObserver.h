//
//  NBKeyBoardObserver.h
//  pengpeng
//
//  Created by jianwei.chen on 15/10/12.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NBKeyBoardObserver;
@protocol NBKeyBoardObserverDelegate <NSObject>
@optional
-(void)keyBoardWillShow:(NBKeyBoardObserver *)observer;
-(void)keyBoardWillHidden:(NBKeyBoardObserver *)observer;
@end

@interface NBKeyBoardObserver : NSObject{
    NSHashTable *_delegates;                 //弱引用delegate
}
@property (nonatomic, assign) BOOL    keyBoardShow;
@property (nonatomic, assign) CGFloat curKeyboardHeight;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
+(instancetype)shareInstance;
-(void)addDelegate:(id<NBKeyBoardObserverDelegate>)delegate;
@end
