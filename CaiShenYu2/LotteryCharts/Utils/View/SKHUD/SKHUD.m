//
//
//  Created by linshaokai on 2016/9/30.
//  Copyright © 2016年 林少凯. All rights reserved.
//

#import "SKHUD.h"
typedef enum
{
    HUDMessage = 0,
    HUDLoading = 1
    
}HUDStatus;
typedef enum
{
    HUDImage = 0,
    HUDDotLayer = 1,
    HUDGif = 2,
    HUDDefault = 3,
    HUDImageClearBg=4,
    HUDNoShow = -1,
    
}HUDLoadType;

#define UIColorSixteen(rgbValue,a) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:a]
//大背景颜色
#define kBackgroundViewColor [UIColor clearColor]
//内容框的圆角大小
static const NSInteger kLoaderCornerRadius = 5;
//加载内容的背景颜色
#define loaderBackgroundColor UIColorSixteen(0x333333,0.7)
//文本的字体颜色
#define statusTextColor  [UIColor whiteColor]
// 字体大小
static const NSInteger kStatusTextFont = 16;
//离背景的最大编辑宽度
static const NSInteger kBgMarginWidth = 30;
//提示内容的最大的文本编剧
static const NSInteger kTextMarginWidth = 10;
//提示内容的最大高度
static const NSInteger kTextMaxHeight = 100;
//界面隐藏的延迟时间
static const NSInteger kHidenDelayTime = 1.5;
//动画隐藏时间
static const CGFloat kAnimalHiden = 0.5;
//默认的加载宽度
static const NSInteger kDefaultLoadingWidth = 100;
//图片的宽度
static const NSInteger kImageLoadingWidth =  34;
//是否支持图片动画
static const BOOL kIsImageAnimal = YES;

#define kLoadingText @"加载中..."
@interface SKHUD ()
@property (strong ,nonatomic) UILabel *messageLabel;
@property (strong ,nonatomic) UIView *bgContentView;
@property (strong ,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong ,nonatomic) UIImageView *loadImageView;
@property (strong ,nonatomic) NSMutableArray *gifImageArray;
@property (nonatomic , strong) CAReplicatorLayer *replicatorLayer;
@property (assign ,nonatomic) HUDLoadType lastLoadType;
@end
@implementation SKHUD
+ (SKHUD *)sharedInstance
{
    static dispatch_once_t once = 0;
    static SKHUD *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SKHUD alloc] init];
    });
    return sharedInstance;
}
#pragma mark - Initialization Methods
- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = kBackgroundViewColor;
        _lastLoadType = -1;
    }
    return self;
}
-(void)createMessage:(NSString *)message loadType:(HUDLoadType)loadType status:(HUDStatus)status superView:(UIView *)superView isAutoDismissView:(BOOL)dismiss
{
    //提示的内容不一样的时候，移除界面上的动画效果
    if (loadType != _lastLoadType) {
        [self removeView];
    }
    _lastLoadType = loadType;
    //当显示的View没有的话，不显示
    //提示内容为空的时候不显示任何效果
    if (!superView || (status == HUDMessage && !KJudgeIsNullData(message))) {
        [self removeView];
        return ;
    }
    self.alpha = 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bgContentView.backgroundColor = loaderBackgroundColor;
        self.messageLabel.textColor = statusTextColor;
        CGFloat viewWidth = CGRectGetWidth(superView.bounds);
        CGFloat viewHeight = CGRectGetHeight(superView.bounds);
        if (viewHeight == (CGRectGetHeight([UIScreen mainScreen].bounds) - 64)) {
            viewHeight -= (64 * 2);
        }
        CGSize size = [self calculateTextSize:kStatusTextFont string:message width:viewWidth];
        CGFloat contentWidth = 0.0;
        CGFloat contentHeight = 0.0;
        if (self->_loadImageView) {
            self->_loadImageView.hidden = YES;
        }
        if (self->_activityIndicatorView) {
            self->_activityIndicatorView.hidden = YES;
        }
        if (status == HUDMessage) {
            self.messageLabel.text = message;
            self.messageLabel.font = [UIFont systemFontOfSize:kStatusTextFont];
            self.bgContentView.backgroundColor = UIColorSixteen(0x000000, 1.0);
            self.messageLabel.textAlignment = NSTextAlignmentLeft;
            self.messageLabel.frame = CGRectMake(kTextMarginWidth, kTextMarginWidth, size.width, size.height);
            contentHeight = size.height + kTextMarginWidth * 2;
            contentWidth = size.width + kTextMarginWidth * 2;
            
        }else
        {
            self.messageLabel.font = [UIFont systemFontOfSize:14];
            self.messageLabel.text = message;
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.frame = CGRectMake(kTextMarginWidth, kDefaultLoadingWidth / 2.0 +  (kDefaultLoadingWidth / 2.0 - 20) / 2.0, kDefaultLoadingWidth - kTextMarginWidth * 2, 20);
            contentWidth = kDefaultLoadingWidth;
            contentHeight = kDefaultLoadingWidth;
            if (loadType == HUDDefault) {
                self.activityIndicatorView.hidden = NO;
                self.activityIndicatorView.frame = CGRectMake((kDefaultLoadingWidth - 20) / 2.0, (kDefaultLoadingWidth / 2.0 - 20) - 5, 20, 20);
                [self startAnimatView];
            }else {
                [self addLoadImageViewOrLayer:loadType];
                self.loadImageView.frame = CGRectMake((kDefaultLoadingWidth - kImageLoadingWidth) / 2.0, (kDefaultLoadingWidth / 2.0 - kImageLoadingWidth), kImageLoadingWidth, kImageLoadingWidth);
                self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                self.loadImageView.backgroundColor = [UIColor clearColor];
                self.loadImageView.layer.cornerRadius = 0;
                self.loadImageView.hidden = NO;
                if (loadType == HUDImage) {
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image = [UIImage imageNamed:@"load_2"];
                    if (kIsImageAnimal) {
                        [self animationWorkForImage];
                    }
                } else if(loadType == HUDImageClearBg){
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image = [UIImage imageNamed:@"load_1"];
                    self.bgContentView.backgroundColor = [UIColor clearColor];
                    self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                    if (kIsImageAnimal) {
                        [self animationWorkForImage];
                    }
                } else if (loadType == HUDDotLayer){
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image =nil;
                    self.loadImageView.backgroundColor = [UIColor whiteColor];
                    self.loadImageView.frame = CGRectMake(kImageLoadingWidth / 2.0, 0, 6, 6);
                    self.loadImageView.layer.cornerRadius = 3;
                    if (kIsImageAnimal) {
                        [self animationWork];
                    }
                } else {
                    self.loadImageView.image = nil;
                    self.bgContentView.backgroundColor = [UIColor whiteColor];
                    self.messageLabel.textColor = [UIColor blackColor];
                    self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                    self.loadImageView.animationImages = self.gifImageArray;
                    self.loadImageView.animationRepeatCount = GID_MAX;
                    self.loadImageView.animationDuration = 0.5;
                    [self.loadImageView startAnimating];
                }
            }
        }
        self.bgContentView.frame = CGRectMake((viewWidth - contentWidth) / 2.0, (viewHeight - contentHeight) / 2.0, contentWidth, contentHeight);
        self.frame = superView.bounds;
        [superView addSubview:self];
        //需要自动隐藏界面
        if (dismiss) {
            [self performSelector:@selector(loadingViewHide) withObject:nil afterDelay:kHidenDelayTime];
        }
    });
}
//移除整个加载界面
- (void)removeLoadingView {
    [self removeView];
    if (self.superview) {
        [self removeFromSuperview];
    }
}
//移除动画效果和延迟事件
- (void)removeView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self stopAnimatView];
}
//整个界面隐藏掉后移除父视图
- (void)loadingViewHide
{
    if (self.alpha == 1) {
        [UIView animateWithDuration:kAnimalHiden delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeLoadingView];
        }];
    }
}

#pragma mark 界面初始化
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = statusTextColor;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:kStatusTextFont];
        [self.bgContentView addSubview:_messageLabel];
    }
    return _messageLabel;
}
-(UIView *)bgContentView
{
    if (!_bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.backgroundColor = loaderBackgroundColor;
        _bgContentView.layer.cornerRadius = kLoaderCornerRadius;
        [self addSubview:_bgContentView];
    }
    return _bgContentView;
}
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.bgContentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(void)addLoadImageViewOrLayer:(HUDLoadType)current
{
    if (current != HUDDotLayer) {
        if (![self.loadImageView superview]) {
            [self.bgContentView.layer addSublayer:self.loadImageView.layer];
        }
    }else {
        if (_replicatorLayer && !_replicatorLayer.superlayer) {
            [self.bgContentView.layer addSublayer:_replicatorLayer];
        }
        [self.replicatorLayer addSublayer:self.loadImageView.layer];
    }
}
//开始Dot样式动画
- (void)animationWork {
     self.loadImageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //从原大小变小时,动画 回到原状时不要动画
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [self.loadImageView.layer addAnimation:animation forKey:nil];
}
//开始图片样式
- (void)animationWorkForImage {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.68;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = GID_MAX;
    [self.loadImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
//开始菊花动画
- (void)startAnimatView {
    if (_lastLoadType == HUDDefault) {
        if (_activityIndicatorView && !_activityIndicatorView.hidden) {
            [_activityIndicatorView startAnimating];
        }
    }
}
//添加点的Layer
- (CAReplicatorLayer *)replicatorLayer {
    if (!_replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = CGRectMake((kDefaultLoadingWidth - kImageLoadingWidth) / 2.0, (kDefaultLoadingWidth / 2.0 - kImageLoadingWidth), kImageLoadingWidth, kImageLoadingWidth);;
        _replicatorLayer.preservesDepth = YES;
        CGFloat count = 8;
        _replicatorLayer.instanceDelay = 1.0 / count;
        _replicatorLayer.instanceCount = count;
        //相对于_replicatorLayer.position旋转
        _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / count, 0, 0, 1.0);
        [self.bgContentView.layer addSublayer:_replicatorLayer];
    }
    return _replicatorLayer;
}
//停止动画效果
- (void)stopAnimatView {
    if (_lastLoadType != -1) {
        if (_lastLoadType == HUDImage || _lastLoadType == HUDDotLayer || _lastLoadType == HUDImageClearBg) {
            if (self.loadImageView && kIsImageAnimal) {
                [self.loadImageView.layer removeAllAnimations];
            }
            if (_lastLoadType == HUDDotLayer) {
                if (_replicatorLayer && _replicatorLayer.superlayer) {
                    [_replicatorLayer removeFromSuperlayer];
                }
            }
        }else if (_lastLoadType == HUDGif)
        {
            if (self.loadImageView && self.loadImageView.animating) {
                [self.loadImageView stopAnimating];
            }
        }else if (_lastLoadType == HUDDefault)
        {
            if (_activityIndicatorView && _activityIndicatorView.animating) {
                [_activityIndicatorView stopAnimating];
            }
        }
    }
}
- (UIImageView *)loadImageView {
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc]init];
    }
    return _loadImageView;
}
//gif 动画数组
- (NSMutableArray *)gifImageArray {
    if (!_gifImageArray) {
        _gifImageArray = [NSMutableArray array];
        for (NSUInteger i = 1; i<=18; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%lu", (unsigned long)i]];
            [_gifImageArray addObject:image];
        }
    }
    return _gifImageArray;
}
//计算提示内容的大小
- (CGSize)calculateTextSize:(CGFloat)font string:(NSString *)content width:(CGFloat)viewWidth {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(viewWidth - (kBgMarginWidth + kTextMarginWidth) * 2,kTextMaxHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size;
}


#pragma mark - public Methods
+ (void)showLoadingDefaultInView:(UIView *)view {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDefault status:HUDLoading superView:view isAutoDismissView:NO];
}

+ (void)showLoadingImageInView:(UIView *)view {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDImage status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingImageInView:(UIView *)view withMessage:(NSString*)message {
      [[SKHUD sharedInstance]createMessage:message loadType:HUDImage status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingImageClearBgInView:(UIView *)view withMessage:(NSString*)message {
          [[SKHUD sharedInstance]createMessage:message loadType:HUDImageClearBg status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingGifInView:(UIView *)view {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDGif status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingDotInView:(UIView *)view {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDotLayer status:HUDLoading superView:view isAutoDismissView:NO];
}
+(void)showLoadingDotInView:(UIView *)view withMessage:(NSString*)message {
    [[SKHUD sharedInstance]createMessage:message loadType:HUDDotLayer status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingDotInWindow {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDotLayer status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingDotInWindowWithMessage:(NSString *)message {
    [[SKHUD sharedInstance]createMessage:message loadType:HUDDotLayer status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}
+ (void)showLoadingDefaultInWindow {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDefault status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingImageInWindow {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDImage status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}
+ (void)showLoadingImageInWindowWithMessage:(NSString *)message {
    [[SKHUD sharedInstance]createMessage:message loadType:HUDImage status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingGifInWindow {
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDGif status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}


+ (void)showMessageInView:(UIView *)view  withMessage:(NSString *)message {
    [[SKHUD sharedInstance] createMessage:message loadType:HUDDefault status:HUDMessage superView:view isAutoDismissView:YES];
}
+ (void)showMessageInWindowWithMessage:(NSString *)message {
    
    [[SKHUD sharedInstance] createMessage:message loadType:HUDDefault status:HUDMessage superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:YES];
}
+ (void)showNetworkErrorMessageInView:(UIView *)view {
    
    [[SKHUD sharedInstance] createMessage:@"网络不给力噢~！请重试~~" loadType:HUDDefault status:HUDMessage superView:view isAutoDismissView:YES];
}

+ (void)showNetworkPostErrorMessageInView:(UIView *)view {
    
    [[SKHUD sharedInstance] createMessage:@"操作有误 请重试~~" loadType:HUDDefault status:HUDMessage superView:view isAutoDismissView:YES];
}

+ (void)dismiss {
    [[SKHUD sharedInstance] removeLoadingView];
}
@end
