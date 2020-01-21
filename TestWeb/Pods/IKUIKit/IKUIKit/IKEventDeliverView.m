//
//  IKEventDeliverView.m
//
//
//  Created by 孙西纯 on 16/2/22.
//
//

#import "IKEventDeliverView.h"

@implementation IKEventDeliverView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [self sendActionToNextResponder];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    [[self nextResponder]motionBegan:motion withEvent:event];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    [[self nextResponder]motionEnded:motion withEvent:event];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    [[self nextResponder]motionCancelled:motion withEvent:event];
}

- (void)remoteControlReceivedWithEvent:(nullable UIEvent *)event
{
    [[self nextResponder]remoteControlReceivedWithEvent:event];
}

-(void)sendActionToNextResponder
{
    if ([[self nextResponder] isKindOfClass:[UIButton class]])
    {
        [(UIButton*)[self nextResponder]sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
@end
