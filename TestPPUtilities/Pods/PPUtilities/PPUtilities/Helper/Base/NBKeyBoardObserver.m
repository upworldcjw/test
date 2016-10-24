//
//  NBKeyBoardObserver.m
//  pengpeng
//
//  Created by jianwei.chen on 15/10/12.
//  Copyright © 2015年 AsiaInnovations. All rights reserved.
//

#import "NBKeyBoardObserver.h"

@implementation NBKeyBoardObserver

+(instancetype)shareInstance{
    static NBKeyBoardObserver *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(instancetype)init{
    if (self = [super init]) {
        self.animationDuration = .3;
        self.animationCurve = UIViewAnimationCurveEaseInOut;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        _delegates = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality capacity:0];
    }
    return self;
}

-(void)addDelegate:(id<NBKeyBoardObserverDelegate>)delegate{
    if (delegate) {
        @synchronized(_delegates) {
            if (![_delegates containsObject:delegate]) {
                [_delegates addObject:delegate];
            }
        }
    }
}

-(void)removeDelegate:(id<NBKeyBoardObserverDelegate>)delegate{
    if (delegate) {
        @synchronized(_delegates) {
            if ([_delegates containsObject:delegate]) {
                [_delegates removeObject:delegate];
            }
        }
    }
}

-(void)dispatchDelegate:(void(^)(id<NBKeyBoardObserverDelegate> delegate))block{
    for (id<NBKeyBoardObserverDelegate> delegate in _delegates) {
        block(delegate);
    }
}

- (void)keyboardInfo:(NSDictionary *)info{
    NSNumber *number = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    self.curKeyboardHeight = CGRectGetHeight([[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    self.animationDuration = [number doubleValue];
    self.animationCurve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    [self keyboardInfo:info];
    [self dispatchDelegate:^(id<NBKeyBoardObserverDelegate> delegate) {
        if([delegate respondsToSelector:@selector(keyBoardWillShow:)]){
            [delegate keyBoardWillShow:self];
        };
    }];
}

- (void)keyboardWillHidden:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    [self keyboardInfo:info];
    [self dispatchDelegate:^(id<NBKeyBoardObserverDelegate> delegate) {
        if([delegate respondsToSelector:@selector(keyBoardWillHidden:)]){
            [delegate keyBoardWillHidden:self];
        };
    }];
}

@end
