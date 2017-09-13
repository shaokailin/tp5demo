//
//  YBAVPlayer.m
//  YBAVPlayer
//
//  Created by ch on 2017/3/20.
//  Copyright © 2017年 杨艺博. All rights reserved.
//

#import "YBAVPlayer.h"

#define TOP_BOTTOM_VIEW_HIGH 35
#define BUTTON_HIGH 30

@interface YBAVPlayer ()
{
    BOOL isDraging;
    BOOL isBuffing;
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *fullScreenBtn;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) YBAVPlayerState state;
@property (nonatomic, strong) UILabel *seekToTimeLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL isEnterBackground;

@end


@implementation YBAVPlayer

- (instancetype)init {
    if (self = [super init]) {
        self.isFullScreen = NO;
        self.isEnterBackground = NO;
        isDraging = NO;
        isBuffing = YES;
        [self setup];
        [self addNotification];
        [self updateSliderValue];
        [self startTimerHideTopBottomView];
    }
    return self;
}

// 添加监听
- (void)addNotification {
    // 监听设备的方向
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDirectionOfEquipment:) name:UIDeviceOrientationDidChangeNotification object:nil];
    // 视频播放完通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayEndAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Action
// 返回按钮
- (void)handleBackBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(backBtnActionWith:)]) {
        [_delegate backBtnActionWith:self.isFullScreen];
    }
    if (self.isFullScreen) {
        [self setVideoPlayViewToSmallScreen];
    }
}

// 播放 / 暂停
- (void)handlePlayBtnAction:(UIButton *)sender {
    if (self.state == YBAVPlayerStatePlaying) {
        self.state = YBAVPlayerStatePause;
        [sender setImage:[UIImage imageNamed:@"icon_play_video@2x.png"] forState:UIControlStateNormal];
        [self.player pause];
    }else{
        self.state = YBAVPlayerStatePlaying;
        [sender setImage:[UIImage imageNamed:@"icon_pause_video@2x.png"] forState:UIControlStateNormal];
        if (isBuffing == NO) {
            [self.player play];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(playOrPauseBtnActionWith:)]) {
        [_delegate playOrPauseBtnActionWith:self.state];
    }
}

// 全屏
- (void)handleFullScreenBtnAction:(UIButton *)sender {
    if (self.isFullScreen) {
        [self setVideoPlayViewToSmallScreen];
    }else {
        [self setVideoPlayViewToFullScreenWith:M_PI_2];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(fullScreenBtnActionWith:)]) {
        [_delegate fullScreenBtnActionWith:self.isFullScreen];
    }
}

// 开始滑动滑竿
- (void)handleSliderTouchBeginAction:(UISlider *)sender {
    isDraging = YES;
    [self removeTimer];
}

// 正在滑动滑竿
- (void)handleSliderTouchMovingAction:(UISlider *)sender {
    [self.activity stopAnimating];
    CGFloat total = (CGFloat)self.playerItem.duration.value / self.playerItem.duration.timescale;
    CGFloat currentTime = total*sender.value;
    NSInteger ss = (NSInteger)currentTime % 60;
    NSInteger mm = (NSInteger)currentTime / 60;
    self.seekToTimeLabel.hidden = NO;
    self.seekToTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", mm, ss];
}

// 停止滑动滑竿
- (void)handleSliderTouchEndAction:(UISlider *)sender {
    isDraging = NO;
    [self startTimerHideTopBottomView];
    // 计算拖动到的秒数
    CGFloat totalTime = (CGFloat)self.playerItem.duration.value / self.playerItem.duration.timescale;
    self.seekToTimeLabel.hidden = YES;
    [self.activity startAnimating];
    [self.player pause];
    CMTime dragedCMTime = CMTimeMake(totalTime * sender.value, 1);
    [self.player seekToTime:dragedCMTime];
}

- (void)handleTapBgViewAction:(UITapGestureRecognizer *)sender {
    if (self.topView.alpha == 0.0) {
        [self showTopBottomControlView];
        [self startTimerHideTopBottomView];
    }else {
        [self hideTopBottomControlView];
        if (self.timer) [self removeTimer];
    }
}

#pragma mark - timerAction
- (void)handleTimerAction:(NSTimer *)sender {
    [self removeTimer];
    [self hideTopBottomControlView];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == _playerItem) {
        if ([keyPath isEqualToString:@"status"]) {
            if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
                //可以获得播放的进度，就可以给播放进度条赋值了, 同时打开slider的用户交互
                //视频总时间
                CGFloat duration = self.playerItem.duration.value / self.playerItem.duration.timescale;
                self.slider.userInteractionEnabled = YES;
                self.timeLabel.text =  [NSString stringWithFormat:@"00:00/%02ld:%02ld", (NSInteger)duration / 60, (NSInteger)duration % 60];
            } else if ([self.playerItem status] == AVPlayerStatusFailed || [self.playerItem status] == AVPlayerStatusUnknown) {
                [self.player pause];
                if (_delegate && [_delegate respondsToSelector:@selector(videoPlayFail)]) {
                    [_delegate videoPlayFail];
                }
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            //监听播放器的下载进度
            NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
            // 获取缓冲区域
            CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
            float startSeconds = CMTimeGetSeconds(timeRange.start);
            float durationSeconds    = CMTimeGetSeconds(timeRange.duration);
            // 计算缓冲总进度
            NSTimeInterval timeInterval = startSeconds + durationSeconds;
            CMTime duration = self.playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            // 缓冲总进度
            [self.progressView setProgress:(CGFloat)timeInterval / totalDuration animated:NO];
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            //由于AVPlayer缓存不足就会自动暂停，所以缓存充足了需要手动播放，才能继续播放
            isBuffing = YES;
            [self.player pause];
            [self.activity startAnimating];
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            isBuffing = NO;
            //缓冲达到可播放程度了
            [self.activity stopAnimating];
            if (self.state == YBAVPlayerStatePlaying && !self.isEnterBackground) {
                [self.player play];
            }
        }
    }
}

#pragma mark - 通知
// 设备方向发生变化
- (void)deviceDirectionOfEquipment:(NSNotification *)sender {
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    switch (orient)
    {
        case UIDeviceOrientationPortrait:
            // 返回小屏幕
            [self setVideoPlayViewToSmallScreen];
            break;
        case UIDeviceOrientationLandscapeLeft:
            // 横屏，电池栏在左
            [self setVideoPlayViewToFullScreenWith:M_PI_2];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            // 返回小屏幕
            break;
        case UIDeviceOrientationLandscapeRight:
            // 横屏，电池栏在右
            [self setVideoPlayViewToFullScreenWith:-M_PI_2];
            break;
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(autoSwitchHorizontalVerticalScreenWith:)]) {
        [_delegate autoSwitchHorizontalVerticalScreenWith:self.isFullScreen];
    }
}

// 视频播放结束
- (void)videoPlayEndAction:(NSNotification *)sender {
    // 播放时间归零,滑竿归零
    [self.player seekToTime:CMTimeMake(0, 1)];
    self.slider.value = 0.0;
    // 播放结束后,停止播放,修改状态
    [self.player pause];
    self.state = YBAVPlayerStatePause;
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play_video@2x.png"] forState:UIControlStateNormal];
    // 代理方法, 视频播放结束后, 可在外部进行处理业务逻辑
    if (_delegate && [_delegate respondsToSelector:@selector(videoEndPlay)]) {
        [_delegate videoEndPlay];
    }
}

// app进入后台
- (void)appDidEnterBackground:(NSNotification *)sender {
    self.isEnterBackground = YES;
    [self.player pause];
}

// app进入前台
- (void)appDidEnterPlayGround:(NSNotification *)sender {
    self.isEnterBackground = NO;
    if (self.state == YBAVPlayerStatePlaying) {
        [self.player play];
    }
}

#pragma mark - 更新进度信息
- (void)updateSliderValue {
    __weak typeof(self) ws = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(ws.playerItem.duration);
        if (currentTime && !isDraging) {
            [ws.slider setValue:(currentTime / totalTime) animated:YES];
        }
        // 当前走过的时间
        NSInteger css = (NSInteger)currentTime % 60;
        NSInteger cmm = (NSInteger)currentTime / 60;
        // 总时间
        NSInteger tss = (NSInteger)totalTime % 60;
        NSInteger tmm = (NSInteger)totalTime / 60;
        ws.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld/%02ld:%02ld",cmm, css, tmm, tss];
    }];
}

- (void)playWith:(NSURL *)videoUrl {
    if (!videoUrl) return;
    // 将之前的监听时间移除掉
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    self.playerItem = nil;
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    // 监听播放状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听音乐缓冲状态
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓冲区, 已经可以播放了
    [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓冲区, 是空的, 还不能播放
    [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    // 关闭slider交互, 防止在还没有获取到视频总长度的时候滑动slider导致crash
    self.slider.userInteractionEnabled = NO;
    self.state = YBAVPlayerStatePlaying;
    [self.activity startAnimating];
}

- (void)setVideoName:(NSString *)videoName {
    if (!videoName || [videoName isKindOfClass:[NSNull class]]) return;
    self.titleLabel.text = videoName;
}

- (void)removeFromSuperview {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (_player) {
        [_player pause];
        self.player = nil;
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [super removeFromSuperview];
    // 卸载监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}

#pragma mark - 外部提供接口方法, 暂停 - 播放
- (void)pause {
    self.state = YBAVPlayerStatePause;
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play_video@2x.png"] forState:UIControlStateNormal];
    [self.player pause];
}

- (void)play {
    self.state = YBAVPlayerStatePlaying;
    [self.playBtn setImage:[UIImage imageNamed:@"icon_pause_video@2x.png"] forState:UIControlStateNormal];
    [self.player play];
}

#pragma mark - 定时器相关, 定时隐藏上下半透明视图
- (void)startTimerHideTopBottomView {
    if (self.timer) [self removeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(handleTimerAction:) userInfo:nil repeats:NO];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark- getter
- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        if([[UIDevice currentDevice] systemVersion].intValue>=10){
            //      增加下面这行可以解决iOS10兼容性问题了
            _player.automaticallyWaitsToMinimizeStalling = NO;
        }
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        if([_playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]){
            _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }else{
            _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        }
    }
    return _playerLayer;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBgViewAction:)];
    }
    return _tap;
}

#pragma mark - 显示或隐藏视图
- (void)hideTopBottomControlView {
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.25 animations:^{
        ws.topView.alpha = 0.0;
        ws.bottomView.alpha = 0.0;
    }];
}

- (void)showTopBottomControlView {
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.25 animations:^{
        ws.topView.alpha = 1.0;
        ws.bottomView.alpha = 1.0;
    }];
}

#pragma mark - 设置全屏或者小屏播放
- (void)setVideoPlayViewToFullScreenWith:(CGFloat)angle {
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"icon_narrow_video@2x.png"] forState:UIControlStateNormal];
    self.isFullScreen = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    [self updateSubViewsConstraintsWith:YES];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.25 animations:^{
        [ws.bgView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}

- (void)setVideoPlayViewToSmallScreen {
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"icon_scale_active.png"] forState:UIControlStateNormal];
    self.isFullScreen = NO;
    [self addSubview:self.bgView];
    [self updateSubViewsConstraintsWith:NO];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.25 animations:^{
        [ws.bgView setTransform:CGAffineTransformMakeRotation(0)];
    }];
}

#pragma mark - initSubViews
- (void)setup {

    self.bgView = [UIView new];
    _bgView.backgroundColor = [UIColor blackColor];
    [_bgView.layer insertSublayer:self.playerLayer atIndex:0];
    [_bgView addGestureRecognizer:self.tap];
    [self addSubview:_bgView];
    
    self.seekToTimeLabel = [UILabel new];
    _seekToTimeLabel.hidden = YES;
    [_seekToTimeLabel setBackgroundColor:[UIColor colorWithRed:5 / 255.0 green:5 / 255.0 blue:5 / 255.0 alpha:0.5]];
    _seekToTimeLabel.textColor = [UIColor whiteColor];
    _seekToTimeLabel.textAlignment = NSTextAlignmentCenter;
    _seekToTimeLabel.layer.cornerRadius = 15;
    _seekToTimeLabel.layer.masksToBounds = YES;
    [_bgView addSubview:_seekToTimeLabel];
    
    self.topView = [UIView new];
    _topView.backgroundColor = [UIColor colorWithRed:5 / 255.0 green:5 / 255.0 blue:5 / 255.0 alpha:0.5];
    [_bgView addSubview:_topView];
    
    self.bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor colorWithRed:5 / 255.0 green:5 / 255.0 blue:5 / 255.0 alpha:0.5];
    [_bgView addSubview:_bottomView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"icon_arrow_video@2x.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(handleBackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backBtn];
    
    self.titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_titleLabel];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn setImage:[UIImage imageNamed:@"icon_pause_video@2x.png"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(handlePlayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playBtn];
    
    self.timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
    _timeLabel.text = @"00:00/00:00";
    [_bottomView addSubview:_timeLabel];
    
    self.progressView = [UIProgressView new];
    [_progressView setProgressTintColor:[UIColor lightGrayColor]];
    [_progressView setTrackTintColor:[UIColor grayColor]];
    [_bottomView addSubview:_progressView];
    
    self.slider = [UISlider new];
    [_slider setThumbImage:[UIImage imageNamed:@"icon_video_time_btn@2x.png"] forState:UIControlStateNormal];
    [_slider setMinimumTrackTintColor:[UIColor whiteColor]];
    [_slider setMaximumTrackTintColor:[UIColor clearColor]];
    // 开始滑动
    [_slider addTarget:self action:@selector(handleSliderTouchBeginAction:) forControlEvents:(UIControlEventTouchDown)];
    // 正在滑动
    [_slider addTarget:self action:@selector(handleSliderTouchMovingAction:) forControlEvents:(UIControlEventValueChanged)];
    // 停止滑动
    [_slider addTarget:self action:@selector(handleSliderTouchEndAction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    [_bottomView addSubview:_slider];
    
    self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullScreenBtn setImage:[UIImage imageNamed:@"icon_narrow_video@2x.png"] forState:UIControlStateNormal];
    [_fullScreenBtn addTarget:self action:@selector(handleFullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fullScreenBtn];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_bgView addSubview:_activity];
    
    [self updateSubViewsConstraintsWith:NO];
}

// 布局
- (void)updateSubViewsConstraintsWith:(BOOL)isFullScreen {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (isFullScreen) {
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(window.mas_centerX);
            make.centerY.equalTo(window.mas_centerY);
            make.width.equalTo(@(window.frame.size.height));
            make.height.equalTo(@(window.frame.size.width));
        }];
    }else {
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(@(0));
        }];
    }
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@(0));
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
    }];
    
    [self.seekToTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.width.equalTo(@(70));
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
    }];
    
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.centerY.equalTo(_topView.mas_centerY);
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
        make.width.equalTo(_backBtn.mas_height).multipliedBy((CGFloat)21/37).offset(15);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backBtn.mas_right).offset(10.0);
        make.centerY.equalTo(_topView.mas_centerY);
        make.right.equalTo(@(-26));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@(0));
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
    }];
    
    [self.playBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
        make.width.equalTo(_playBtn.mas_height).multipliedBy((CGFloat)36/46).offset(15);
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_playBtn.mas_right).offset(5.0);
    }];
    
    [self.fullScreenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.height.equalTo(@(TOP_BOTTOM_VIEW_HIGH));
        make.right.equalTo(@(0));
        make.width.equalTo(_fullScreenBtn.mas_height).multipliedBy(1.0);
    }];
    
    [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY).offset(1.0);
        make.left.equalTo(_timeLabel.mas_right).offset(5.0);
        make.right.equalTo(_fullScreenBtn.mas_left).offset(-10.0);
        make.height.equalTo(@(2.0));
    }];
    
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_timeLabel.mas_right).offset(5.0);
        make.right.equalTo(_fullScreenBtn.mas_left).offset(-10.0);
        make.height.equalTo(@(BUTTON_HIGH));
    }];
    
    [self.activity mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.width.height.equalTo(@(25));
    }];
}

// 更新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.playerLayer setFrame:self.bgView.bounds];
}

@end
