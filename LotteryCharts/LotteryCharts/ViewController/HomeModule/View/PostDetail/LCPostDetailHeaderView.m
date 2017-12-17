//
//  LCPostDetailHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailHeaderView.h"
#import "PYPhotoBrowser.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
@interface LCPostDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *shangBtn;
@property (weak, nonatomic) IBOutlet UILabel *shangCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shangTopHeight;
@property (nonatomic, weak) PYPhotosView *linePhotosView;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSURL *downLoadPath;
@end
@implementation LCPostDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBoundsRadius(self.photoImage, 30);
    ViewRadius(self.careBtn, 5.0);
    ViewBorderLayer(self.careBtn, ColorHexadecimal(0xf6a623, 1.0), 1.0);
    
    ViewRadius(self.shangBtn, 35 / 2.0);
    
    self.contentLbl.text = nil;
    PYPhotosView *linePhotosView = [PYPhotosView photosViewWithThumbnailUrls:nil originalUrls:nil layoutType:PYPhotosViewLayoutTypeLine];
    // 设置Frame
    linePhotosView.py_y = 0;
    linePhotosView.py_x = PYMargin * 2;
    linePhotosView.py_width = 80;
    linePhotosView.py_height = 80;
    self.voiceBtn.hidden = YES;
    self.voiceTimeLbl.hidden = YES;
    self.linePhotosView = linePhotosView;
    [self.imageBgView addSubview:linePhotosView];
}
- (void)setupRewardCount:(NSInteger)count {
    self.shangCountLbl.text = NSStringFormat(@"%zd人打赏了帖主",count);
}
- (void)setupContent:(NSString *)content media:(NSDictionary *)mediaDict isShow:(BOOL)isCanShow {
    self.contentLbl.text = content;
    if (!isCanShow) {
    }else {
        self.contentLbl.text = content;
        if (mediaDict && [mediaDict isKindOfClass:[NSDictionary class]]) {
            NSArray *images = [mediaDict objectForKey:@"images"];
            if (KJudgeIsArrayAndHasValue(images)) {
                self.linePhotosView.originalUrls = images;
            }
            BOOL isVoice = NO;;
            NSDictionary *voiceDict = [mediaDict objectForKey:@"record"];
            if (voiceDict) {
                NSString *url = [voiceDict objectForKey:@"url"];
                if (KJudgeIsNullData(url)) {
                    if (!_audioUrl || ![_audioUrl isEqualToString:url]) {
                        self.audioUrl = url;
                    }
                    self.voiceTimeLbl.text = NSStringFormat(@"%@'",[voiceDict objectForKey:@"time"]);
                    isVoice = YES;
                }
            }
            self.voiceBtn.hidden = !isVoice;
            self.voiceTimeLbl.hidden = !isVoice;
            if (self.frameBlock) {
                if (isVoice && self.shangTopHeight.constant <= 20.0) {
                    self.shangTopHeight.constant = 60;
                    self.frameBlock(CGRectGetHeight(self.frame) + 40);
                }else if (!isVoice && self.shangTopHeight.constant > 30) {
                    self.shangTopHeight.constant = 20;
                    self.frameBlock(CGRectGetHeight(self.frame) - 40);
                }
            }
        }
    }
}
- (IBAction)playVoiece:(id)sender {
    if (_audioPlayer && [_audioPlayer isPlaying]) {
        _audioPlayer.currentTime = 0;
        [_audioPlayer stop];
        return;
    }else if (!_audioPlayer && !_downLoadPath){
        if (!_isLoading) {
            _isLoading = YES;
            [self downloadAudio];
        }
        
    }else {
        [self.audioPlayer play];
    }
    
}
- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                                sizeof(sessionCategory),
                                &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (audioRouteOverride),
                                 &audioRouteOverride);
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        //默认情况下扬声器播放
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        //建议播放之前设置yes，播放结束设置no，这个功能是开启红外感应
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        //添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChange:)
                                                     name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:nil];
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.downLoadPath error:&error];
        _audioPlayer.numberOfLoops = 0;
    }
    return _audioPlayer;
}
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId money:(NSString *)money title:(NSString *)title content:(NSString *)content postId:(NSString *)postId time:(NSString *)time count:(NSString *)count type:(NSInteger)type {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.countLbl.text = NSStringFormat(@"付币帖 %@金币",money);
    self.titleLbl.text = title;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    
    self.timeLbl.text = time;
    self.shangCountLbl.text = NSStringFormat(@"%@人打赏了帖主",count);
    if (type == 0) {
        self.shangBtn.hidden = NO;
        self.shangCountLbl.hidden = NO;
        self.careBtn.hidden = NO;
    }else {
        self.shangBtn.hidden = YES;
        self.shangCountLbl.hidden = YES;
        self.careBtn.hidden = YES;
    }
}
- (IBAction)careClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(0, 0);
    }
}
- (void)imageClick1 {
    if (self.headerBlock) {
        self.headerBlock(1, 0);
    }
}
- (void)imageClick2 {
    if (self.headerBlock) {
        self.headerBlock(1, 1);
    }
}
- (void)imageClick3 {
    if (self.headerBlock) {
        self.headerBlock(1, 2);
    }
}
- (IBAction)rewardClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(2, 0);
    }
}
- (void)setIsCare:(BOOL)isCare {
    _isCare = isCare;
    if (_isCare) {
        [self.careBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else {
        [self.careBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)downloadAudio {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.audioUrl]];
    //下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
    }destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //保存的文件路径
//        LCPublicMethod
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
        
    }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",filePath);
        if (error == nil) {
            self.downLoadPath = filePath;
            [self.audioPlayer play];
        }else {
            _isLoading = NO;
            [SKHUD showMessageInWindowWithMessage:@"播放失败"];
        }
    }];
    
    //执行Task
    [download resume];
}

@end
