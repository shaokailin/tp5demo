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
#import "LCFefineTextView.h"
@interface LCPostDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *shangBtn;
@property (weak, nonatomic) IBOutlet UILabel *shangCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UILabel *payLab;

@property (weak, nonatomic) IBOutlet UILabel *comentLab;

@property (weak, nonatomic) IBOutlet LCFefineTextView *contentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTVHeight;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shangTopHeight;
@property (nonatomic, strong) PYPhotosView *linePhotosView;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSURL *downLoadPath;
@property (weak, nonatomic) IBOutlet UIButton *zanbtn;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;


@end
@implementation LCPostDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.payLab.hidden = YES;
    ViewBoundsRadius(self.photoImage, 28);
    ViewRadius(self.careBtn, 5.0);
    ViewBorderLayer(self.careBtn, ColorHexadecimal(0xf6a623, 1.0), 1.0);
    ViewRadius(self.payBtn, 5.0);
    ViewBorderLayer(self.payBtn, ColorHexadecimal(0xf6a623, 1.0), 1.0);
    ViewRadius(self.shangBtn, 35 / 2.0);
    self.payBtn.hidden = YES;
//    self.contentTextView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentTextView.text = nil;
    PYPhotosView *linePhotosView = [PYPhotosView photosViewWithThumbnailUrls:nil originalUrls:nil layoutType:PYPhotosViewLayoutTypeFlow];
    // 设置Frame
    self.imageBgView.backgroundColor = [UIColor whiteColor];
    linePhotosView.photosMaxCol = 1;
    linePhotosView.py_y = 60;
    linePhotosView.py_x = 36;
    linePhotosView.photoMargin = 20;
    linePhotosView.py_width = SCREEN_WIDTH - 36 * 2;
    linePhotosView.py_height = 80;
    linePhotosView.photoHeight = 300;
    linePhotosView.photoWidth = SCREEN_WIDTH - 36 * 2;
    self.voiceBtn.hidden = YES;
    self.voiceTimeLbl.hidden = YES;
    self.linePhotosView = linePhotosView;
    [self.imageBgView addSubview:linePhotosView];
    
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}

- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}

- (void)setupPayBtnState:(BOOL)isPay {
    self.payBtn.hidden = !isPay;
    self.countLbl.hidden = !isPay;
//    self.payLab.hidden = !isPay;
    self.comentLab.hidden = isPay;
    
}

- (IBAction)payPostClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(3, 0);
    }
}
- (void)setupRewardCount:(NSInteger)count {
    self.shangCountLbl.text = NSStringFormat(@"%zd人打赏了帖主",count);
}
- (void)setupContent:(NSString *)content media:(NSDictionary *)mediaDict isShow:(BOOL)isCanShow {
    self.contentTextView.text = content;
    CGFloat contentHeight = [self.contentTextView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 50, MAXFLOAT)].height;
    //            CGFloat contentHeight = [content calculateTextHeight:12 width:SCREEN_WIDTH - 50] + 20;
    if (contentHeight < 30) {
        contentHeight = 30;
    }
    self.contentTVHeight.constant = contentHeight;
    CGFloat viewHeight = contentHeight + 144;
    viewHeight += 17;
    if (isCanShow) {
        if (mediaDict && [mediaDict isKindOfClass:[NSDictionary class]]) {
            NSArray *images = [mediaDict objectForKey:@"images"];
            if (KJudgeIsArrayAndHasValue(images)) {
                CGFloat imageHeight = images.count * 300 + 20 *(images.count + 1);
                self.linePhotosView.py_height = imageHeight;
                viewHeight += (imageHeight);
                self.imageHeight.constant = imageHeight;
                self.linePhotosView.photosMaxCol = 1;
                self.linePhotosView.originalUrls = images;
                self.imageBgView.backgroundColor = ColorHexadecimal(0xF6F6F6, 1.0);
            }else {
                self.linePhotosView.originalUrls = nil;
                self.linePhotosView.photosMaxCol = 1;
                self.imageHeight.constant = 80;
                self.linePhotosView.py_height = 80;
                viewHeight += 80;
                self.imageBgView.backgroundColor = [UIColor whiteColor];
            }
            BOOL isVoice = NO;
            id record = [mediaDict objectForKey:@"record"];
            if (record && [record isKindOfClass:[NSDictionary class]]) {
                NSDictionary *voiceDict = (NSDictionary *)record;
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
            if (isVoice) {
                viewHeight += 15;
                viewHeight += 25;
                viewHeight += 6;
            }else {
                viewHeight += 0;
            }
            if (!self.isUser) {
                viewHeight += 100;
            }
            if (self.frameBlock) {
                self.frameBlock(viewHeight);
            }
            return;
        }
    }else {
        self.imageHeight.constant = 80;
        self.linePhotosView.py_height = 80;
        self.imageBgView.backgroundColor = [UIColor whiteColor];
        viewHeight += 80;
        viewHeight += 24;
    }
    if (!self.isUser) {
        viewHeight += 100;
    }
    if (self.frameBlock) {
        self.frameBlock(viewHeight);
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
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId money:(NSString *)money title:(NSString *)title content:(NSString *)content postId:(NSString *)postId time:(NSString *)time count:(NSString *)count type:(NSInteger)type zanshu:(NSString *)zanshu isZan:(BOOL)isZan {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImage.image = nil;
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.countLbl.text = NSStringFormat(@"付币帖 %@金币",money);
    self.titleLbl.text = title;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    
    if ([self.postType isEqualToString:@"1"]) {
        self.comentLab.text = @"金币帖";

    } else  {
        self.comentLab.text = @"回复帖";
    }
    
    self.timeLbl.text = time;
    self.shangCountLbl.text = NSStringFormat(@"%@人打赏了帖主",count);
    self.zanbtn.selected = isZan;
    self.zanbtn.userInteractionEnabled = !isZan;
    self.zanLbl.text = NSStringFormat(@"%@人赞了帖主",zanshu);
    self.isUser = type;
    if (type == 0) {
        self.actionView.hidden = NO;
        self.careBtn.hidden = NO;
    }else {
        self.actionView.hidden = YES;
        self.careBtn.hidden = YES;
    }
}
- (void)changeZanCount:(NSString *)count{
    self.zanbtn.selected = YES;
    self.zanbtn.userInteractionEnabled = NO;
    self.zanLbl.text = NSStringFormat(@"%@人赞了帖主",count);
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
- (IBAction)zanClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(10, 0);
    }
}
- (void)setIsCare:(BOOL)isCare {
    _isCare = isCare;
    if (_isCare) {
        [self.careBtn setTitle:@"取消关注" forState:UIControlStateNormal];
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
