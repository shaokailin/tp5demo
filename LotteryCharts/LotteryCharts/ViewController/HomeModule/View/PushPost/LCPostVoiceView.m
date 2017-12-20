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
#import "LCPublicMethod.h"
#import "NSTimer+Extend.h"
@interface LCPostVoiceView ()<AVAudioRecorderDelegate>
{
    NSInteger _timeString;
    NSURL *urlPlay;
}
@property (weak, nonatomic) IBOutlet UILabel *closeLbl;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (weak, nonatomic) IBOutlet UILabel *openLbl;
@property (nonatomic, strong) NSTimer *audioTimer;
@end
@implementation LCPostVoiceView

- (void)awakeFromNib {
    [super awakeFromNib];
    _timeString = 0;
    self.closeLbl.hidden = YES;
    ViewRadius(self.voiceBtn, 75 / 2.0);
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [self addGestureRecognizer:tapView];
    [self.voiceBtn addTarget:self action:@selector(offsetButtonTouchBegin:)forControlEvents:UIControlEventTouchDown];
    [self.voiceBtn addTarget:self action:@selector(offsetButtonTouchEnd:)forControlEvents:UIControlEventTouchUpInside];
    [self.voiceBtn addTarget:self action:@selector(offsetButtonTouchEnd:)forControlEvents:UIControlEventTouchUpOutside];
    //button长按事件
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
//    [self.voiceBtn addGestureRecognizer:longPress];
}
-(void) offsetButtonTouchBegin:(id)sender{
    LSKLog(@"12");
    [self performSelector:@selector(startRecord) withObject:nil afterDelay:0.2];
}
- (void)startRecord {
    if (![self.audioRecorder isRecording]) {
        self.closeLbl.hidden = NO;
        self.openLbl.hidden = YES;
        //开始
        [_audioRecorder record];
        [self.audioTimer isValid];
    }
}
-(void) offsetButtonTouchEnd:(id)sender{
    LSKLog(@"122");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (_audioRecorder && _audioRecorder.isRecording) {
        [self.audioRecorder stop];
        [self.audioTimer invalidate];
        _audioTimer = nil;
        self.closeLbl.hidden = YES;
        self.openLbl.hidden = NO;
        if (_timeString == 0) {
            [SKHUD showMessageInView:self withMessage:@"录音时间太段"];
            return;
        }
        if (self.voiceBlock) {
            self.voiceBlock(_timeString);
        }
        [self hidenView];
    }
}

- (void)hidenView {
    self.hidden = YES;
}
- (NSTimer *)audioTimer {
    if (!_audioTimer) {
        _audioTimer = [NSTimer initTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
            _timeString ++;
            LSKLog(@"11111");
        } repeats:YES runModel:NSRunLoopCommonModes];
    }
    return _audioTimer;
}
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        //设置定时检测
        NSURL *url = [LCPublicMethod getRecordUrl];
        urlPlay = url;
        NSError *error;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:[self audioRecordingSettings] error:&error];
        //开启音量检测
        if (error != nil) {
            [SKHUD showMessageInView:self withMessage:@"暂不支持录音功能"];
            [self performSelector:@selector(hidenView) withObject:nil afterDelay:1.0];
            return nil;
        }
        _audioRecorder.delegate = self;
        [_audioRecorder prepareToRecord];
        _audioRecorder.meteringEnabled = YES;
    }
    return _audioRecorder;
}
- (NSDictionary *)audioRecordingSettings{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    return recordSetting;
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    LSKLog(@"%@",error);
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    LSKLog(@"112");
}
@end
