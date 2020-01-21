//
//  IKAudioRecord.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

@protocol IKAudioRecorderDelegate<NSObject>
@optional

- (void)recorderValueChange:(float)value;
- (void)recorderSuccess:(NSString *)path duration:(float)duration;
- (void)recorderLimit:(float)value;
- (void)recorderMax:(float)value;
- (void)recorderTimeChange:(float)value;
@end

@interface IKAudioRecorder : NSObject<AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
  NSTimer *timer;
  int _retryTimes;
  double _recordTime;
}

@property(strong, nonatomic) AVAudioPlayer *avPlay;
@property(strong, nonatomic) AVAudioRecorder *avRecorder;
@property(nonatomic, weak) id<IKAudioRecorderDelegate> delegate;
@property(nonatomic, copy) NSString *tempFilePath;

- (void)initRecorder:(NSString *)path;

- (void)startRecord;
- (void)endRecord;
- (void)cancelRecord;

- (void)playRecord:(NSData *)audioData;
- (void)stopPlay;

@end
