//
//  IMChatViewController.m
//  IMChatKit
//
//  Created by 王虎 on 2017/1/12.
//  Copyright © 2017年 hoowang. All rights reserved.
//

#import "IMChatViewController.h"

#import "MessageInputController.h"
#import "ChatMessageController.h"


@interface IMChatViewController ()
/** MessageView Ref*/
@property (weak, nonatomic) UIView* chatMessageView;

/** MessageInputView Ref*/
@property (weak, nonatomic) UIView* inputView;

@end

@implementation IMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubComponents];
}

- (void)initSubComponents{
    ChatMessageController*  chatMessageController = [[ChatMessageController alloc] init];
    [self addChildViewController:chatMessageController];
    [self.view addSubview:chatMessageController.view];
    self.chatMessageView = chatMessageController.view;

    //chatMessageController.view.frame = self.view.bounds;

    MessageInputController* inputController = [[MessageInputController alloc] init];
    [self addChildViewController:inputController];
    [self.view addSubview:inputController.view];
    self.inputView = inputController.view;

    //inputController.view.frame = self.view.bounds;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self layoutSubControls];
}

- (void)layoutSubControls{
    //self.inputView.frame = CGRectMake(0, 400, self.view, <#CGFloat height#>)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
