//
//  LCPostVoiceView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostVoiceView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface LCPostVoiceView ()<AVAudioRecorderDelegate>
{
    NSInteger _timeString;
    NSURL *urlPlay;
}
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSTimer *audioTimer;
@end
@implementation LCPostVoiceView

- (void)awakeFromNib {
    [super awakeFromNib];
    _timeString = 0;
    ViewRadius(self.voiceBtn, 75 / 2.0);
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [self addGestureRecognizer:tapView];
    [self.voiceBtn addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 3 * 60; //定义按的时间
    [self.voiceBtn addGestureRecognizer:longPress];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                // Microphone enabled code
            }
            else {
                // Microphone disabled code
            }
        }];
    }
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
         [self hidenView];
        if (self.voiceBlock) {
            self.voiceBlock(@"123");
        }
    }
}
- (void)hidenView {
    [self removeFromSuperview];
}
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
//        if ([recorder prepareToRecord]) {
//            //开始
//            [recorder record];
//        }
        //设置定时检测
        timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
        NSFileManager *filePathmanger = [NSFileManager defaultManager];
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:@"/Record"];
        [filePathmanger createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/%@/postAudio.aac", filePath]];
        NSData *dataRecord = [NSData dataWithContentsOfURL:url];
        [dataRecord writeToFile:filePath atomically:YES];
        
        urlPlay = url;
        NSError *error;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:[self audioRecordingSettings] error:&error];
        //开启音量检测
        _audioRecorder.delegate = self;
        [_audioRecorder prepareToRecord];
        _audioRecorder.meteringEnabled = YES;
    }
    return _audioRecorder;
}
- (NSDictionary *)audioRecordingSettings{
    
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatAppleLossless] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    return result;
}
@end
