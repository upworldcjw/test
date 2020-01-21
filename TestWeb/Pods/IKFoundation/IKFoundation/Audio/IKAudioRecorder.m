//
//  IKAudioRecord.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKAudioRecorder.h"
#import "FCBasics.h"

@implementation IKAudioRecorder

- (void)initRecorder:(NSString *)path {
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC]
                     forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000]
                     forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1]
                     forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:8]
                     forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin]
                     forKey:AVEncoderAudioQualityKey];
    
    _tempFilePath = path;
    NSURL *tempurl = [NSURL fileURLWithPath:path];
    NSError *error;
    //初始化
    _avRecorder = [[AVAudioRecorder alloc] initWithURL:tempurl
                                              settings:recordSetting
                                                 error:&error];
    //开启音量检测
    _avRecorder.meteringEnabled = YES;
    _avRecorder.delegate = self;
}

- (void)playRecord:(NSData *)audioData {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //  _avPlay =
    //      [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:url]
    //                                             error:nil];
    _avPlay = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    _avPlay.delegate = self;
    
    if (_avPlay.playing) {
        [_avPlay stop];
        return;
    }
    
    _avPlay.volume = 1.0;
    [_avPlay play];
}

- (void)stopPlay {
    if (_avPlay && _avPlay.isPlaying) {
        [_avPlay stop];
    }
}

- (void)startRecord
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
    //创建录音文件，准备录音
    if ([_avRecorder prepareToRecord]) {
        //开始
        [_avRecorder record];
    }
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(detectionVoice)
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];
}

- (void)cancelRecord
{
    [_avRecorder stop];
    [timer invalidate];
}

- (void)endRecord
{
    _recordTime = _avRecorder.currentTime;
    [_avRecorder stop];
    [timer invalidate];
    
    if (_recordTime < 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(recorderLimit:)]) {
            [_delegate recorderLimit:_recordTime];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(recorderSuccess:duration:)] && _tempFilePath.length > 0) {
            [_delegate recorderSuccess:_tempFilePath duration:_recordTime];
        }
    }
}

- (void)detectionVoice
{
    [_avRecorder updateMeters];  //刷新音量数据
    //获取音量的平均值
    [_avRecorder averagePowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [_avRecorder peakPowerForChannel:0]));
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(recorderValueChange:)]) {
            [_delegate recorderValueChange:lowPassResults];
        }
        if ([_delegate respondsToSelector:@selector(recorderTimeChange:)]) {
            [_delegate recorderTimeChange:_avRecorder.currentTime];
        }
    }
}

- (void)dealloc
{
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
}

@end
