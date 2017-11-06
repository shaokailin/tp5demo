//
//  PPSSSpeechManager.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSSpeechManager.h"
#import "SynthesizeSingleton.h"
#import <AVFoundation/AVFoundation.h>
@interface PPSSSpeechManager ()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) NSMutableArray *speechArray;
@property (nonatomic, assign) BOOL isSpeeching;
@property (nonatomic, strong) AVSpeechSynthesizer *avSpeech;
@property (nonatomic, strong) AVSpeechSynthesisVoice *voice;
@end
@implementation PPSSSpeechManager
SYNTHESIZE_SINGLETON_CLASS(PPSSSpeechManager);
- (instancetype)init{
    self = [super init];
    if (self){
        self->_queue = [[NSMutableArray alloc] init];
        self->_synthesizer = [[AVSpeechSynthesizer alloc] init];
        [self->_synthesizer setDelegate:self];
        _play = true;
        self->_audioSession = [AVAudioSession sharedInstance];
        [_audioSession setActive:YES error:nil];
        self.duckOthers = YES;
    }
    return self;
}

- (void)readLast:(NSString*)message {
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:@"zh-CN" andRate:0.5];
    [_queue addObject:utterance];
    [self next];
}

- (void)readNext:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue{
    if (clearQueue)
        [self clearQueue];
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:language andRate:rate];
    [_queue insertObject:utterance atIndex:0];
    [self next];
}

- (void)readImmediately:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue{
    if (clearQueue)
        [self clearQueue];
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:language andRate:rate];
    [_queue insertObject:utterance atIndex:0];
    [self next];
    
}

- (void)setDuckOthers:(BOOL)duck{
    _duckOthers = duck;
    if (duck)
        [_audioSession setCategory:AVAudioSessionCategoryPlayback
                       withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    else
        [_audioSession setCategory:AVAudioSessionCategoryPlayback
                       withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
}

#pragma mark Internal
- (void)next{
    if (_play && [_queue count] > 0 && ![_synthesizer isSpeaking]){
        AVSpeechUtterance *utterance = [_queue firstObject];
        [_queue removeObjectAtIndex:0];
        [_synthesizer speakUtterance:utterance];
    }
}

- (AVSpeechUtterance*)createUtteranceWithString:(NSString*)message andLanguage:(NSString*)language andRate:(float)rate{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:message];
    [utterance setRate:rate];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:language]];
    [utterance setPreUtteranceDelay:[self preDelay]];
    [utterance setPostUtteranceDelay:[self postDelay]];
    return utterance;
}

#pragma mark Controls
- (void)resume{
    _play = true;
    if (![_synthesizer continueSpeaking])
        [self next];
}

- (void)pause{
    [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    _play = false;
}

- (void)pauseAfterCurrent{
    _play = false;
}

- (void)stop{
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    _play = false;
    [self clearQueue];
}

- (void)stopAfterCurrent{
    _play = false;
    [self clearQueue];
}

- (void)clearQueue{
    [_queue removeAllObjects];
}

#pragma mark AVSpeechSynthesizerDelegate Protocol
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueDidStartTalking:)])
        [self.delegate speechSynthesizerQueueDidStartTalking:self];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueDidPauseTalking:)])
        [self.delegate speechSynthesizerQueueDidPauseTalking:self];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueDidContinueTalking:)])
        [self.delegate speechSynthesizerQueueDidContinueTalking:self];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueDidCancelTalking:)])
        [self.delegate speechSynthesizerQueueDidCancelTalking:self];
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueWillStartTalking:)])
        [self.delegate speechSynthesizerQueueWillStartTalking:self];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    if ([self.delegate respondsToSelector:@selector(speechSynthesizerQueueDidFinishTalking:)])
        [self.delegate speechSynthesizerQueueDidFinishTalking:self];
    [self next];
}
@end
