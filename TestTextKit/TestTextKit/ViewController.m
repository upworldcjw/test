//
//  ViewController.m
//  TestTextKit
//
//  Created by jianwei on 06/12/2016.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UILabel* label;
    
    NSTextContainer *textContainer;
    NSLayoutManager *layoutManager;
    NSTextStorage   *textStorage;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, 350, 300)];
    label.backgroundColor=[UIColor greenColor];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer*  tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapOnLabel:)];
    [tap setNumberOfTapsRequired:1];
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
    
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:@"String with a link" attributes:nil];
    NSRange linkRange = NSMakeRange(14, 4); // for the word "link" in the string above
    NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.4 blue:0.65 alpha:1.0],NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
    [attributedString setAttributes:linkAttributes range:linkRange];
    
    // Assign attributedText to UILabel
    label.attributedText = attributedString;
    
    // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    layoutManager = [[NSLayoutManager alloc] init];
    textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    
    // Configure layoutManager and textStorage
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    
    // Configure textContainer
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = label.lineBreakMode;
    textContainer.maximumNumberOfLines = label.numberOfLines;
}

//each time the label changes its frame, update textContainer's size:
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    textContainer.size = label.bounds.size;
    NSLog(@"textContainer.size=%@",NSStringFromCGSize(textContainer.size));
}

- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"Tap received");
    
    CGPoint locationOfTouchInLabel = [tapGesture locationInView:tapGesture.view];
    CGSize labelSize = tapGesture.view.bounds.size;
    
//    [layoutManager ensureLayoutForGlyphRange:NSMakeRange(0,layoutManager.textStorage.length)];
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    NSLog(@"textBoundingBox=%@",NSStringFromCGRect(textBoundingBox));
    
    CGPoint textContainerOffset = CGPointMake(textBoundingBox.origin.x,(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,locationOfTouchInLabel.y - textContainerOffset.y);
    NSInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    NSRange linkRange = NSMakeRange(14, 4); // it's better to save the range somewhere when it was originally used for marking link in attributed string
    if (NSLocationInRange(indexOfCharacter, linkRange))
    {
        // Open an URL, or handle the tap on the link in any other way
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://stackoverflow.com/"]];
        NSLog(@" Link was taped ");
    }
}

@end
