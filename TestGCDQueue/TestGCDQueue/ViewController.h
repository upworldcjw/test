//
//  ViewController.h
//  TestGCDQueue
//
//  Created by jianwei on 01/12/2016.
//  Copyright © 2016 jianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    dispatch_queue_t _serialQueue;
    dispatch_queue_t _concurrentQueue;
}



@end

