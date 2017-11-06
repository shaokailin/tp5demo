//
//  HSPBarnerScrollView.m
//  HSPlan
//
//  Created by hsPlan on 2017/6/26.
//  Copyright © 2017年 厦门花生计划网络科技公司. All rights reserved.
//

#import "LSKBarnerScrollView.h"
#import "NSTimer+Extend.h"
#import "LSKBannerImageView.h"
#import "PPSSLoginModel.h"
@interface LSKBarnerScrollView ()<UIScrollViewDelegate>
{
    /**默认图片*/
    UIImage *_placeHolderImage;
}
@property (nonatomic, strong) UIScrollView *bannerScrollView;
//页码控制器
@property (nonatomic, strong) UIPageControl *pageControl;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//图片数组
@property (nonatomic, strong) NSArray *imageUrlArray;
/**点击照片的回调*/
@property (nonatomic, copy)LSKImageClickBlock didSelectedImageAtIndex;

@property (nonatomic, copy) UIImageView *defaultImageView;
@end
@implementation LSKBarnerScrollView

- (instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageDidSelectedBlock:(LSKImageClickBlock)didSelectedImageAtIndex {
    if (self = [super initWithFrame:frame]) {
        _placeHolderImage = placeHolderImage;
        _didSelectedImageAtIndex = didSelectedImageAtIndex;
        [self addSubview:self.defaultImageView];
    }
    return self;
}
- (UIImageView *)defaultImageView {
    if (!_defaultImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.image = ImageNameInit(@"guanggao");
        _defaultImageView = imageView;
    }
    return _defaultImageView;
}
- (void)setupBannarContentWithUrlArray:(NSArray *)urlArray {
    if (urlArray && urlArray.count > 0) {
        [_defaultImageView removeFromSuperview];
        _imageUrlArray = urlArray;
        [self setupContentView];
        [self setupContentValue];
    }else {
        if (_defaultImageView && [_defaultImageView superview]) {
            [self addSubview:_defaultImageView];
        }
        if (_imageUrlArray != nil) {
            for (UIView *imageView in self.bannerScrollView.subviews) {
                [imageView removeFromSuperview];
            }
            [self.bannerScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            self.pageControl.hidden = YES;
            if (_timer) {
                [_timer pauseTimer];
            }
        }
    }
}
/**
 图片点击问题
 @param tap 手势事件对象
 */
- (void)imageClickTap :(UITapGestureRecognizer *)tap {
    if (self.didSelectedImageAtIndex && _imageUrlArray.count > 0) {
        if (_imageUrlArray.count == 1) {
            self.didSelectedImageAtIndex(0);
        }else {
            self.didSelectedImageAtIndex(self.pageControl.currentPage);
        }
    }
}
//暂停bannar 动画
- (void)viewDidDisappearStop {
    if (_timer && _imageUrlArray && _imageUrlArray.count > 0) {
        [_timer pauseTimer];
    }
}
//开始 bannar 动画
- (void)viewDidAppearStartRun {
    if (_timer && _imageUrlArray && _imageUrlArray.count > 0) {
        [_timer resumeTimer:kFGGScrollInterval];
    }
}
#pragma mark - 设置整个内容的
//设置图片的内容
- (void)setupContentView {
    
    NSInteger bannerHasViewCount = self.bannerScrollView.subviews.count;
    NSInteger imageArrayCount = _imageUrlArray.count == 0 ? 1 : _imageUrlArray.count;
    
    if (_imageUrlArray.count < 2) {
        for (UIView *subImageView in self.bannerScrollView.subviews) {
            [subImageView removeFromSuperview];
        }
        LSKBannerImageView *imageView = [[LSKBannerImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) placeHolderImage:_placeHolderImage];
        if (_imageUrlArray.count > 0) {
            PPSSBannerModel *model = [_imageUrlArray objectAtIndex:0];
            imageView.imageWebUrl = model.image;
        }
        [self.bannerScrollView addSubview:imageView];
        return;
    }
    imageArrayCount += 2;
    if (bannerHasViewCount != imageArrayCount) {
        NSInteger count = imageArrayCount - bannerHasViewCount;
        if (count > 0) {
            for (int i = 0; i < count; i++) {
                @autoreleasepool {
                    LSKBannerImageView *imageView = [[LSKBannerImageView alloc]initWithFrame:CGRectMake((bannerHasViewCount + i) * CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) placeHolderImage:_placeHolderImage];
                    [self.bannerScrollView addSubview:imageView];
                }
            }
        }else {
            for (int i = 0; i < labs(count); i++) {
                LSKBannerImageView *imageView = (LSKBannerImageView *)self.bannerScrollView.subviews.lastObject;
                [imageView removeFromSuperview];
                imageView = nil;
            }
        }
    }
    for (int i = 0; i < imageArrayCount; i++) {
        LSKBannerImageView *imageView = (LSKBannerImageView *)[self.bannerScrollView.subviews objectAtIndex:i];
        PPSSBannerModel *model = nil;
        if (i == 0) {
            model = _imageUrlArray.lastObject;
        }else if (i == imageArrayCount - 1){
            model = _imageUrlArray.firstObject;
        }else {
            model = [_imageUrlArray objectAtIndex:i - 1];
        }
        imageView.imageWebUrl = model.image;
        [imageView loadWebImageView];
    }
    
}
//设置布局
- (void)setupContentValue {
    NSInteger countImages = _imageUrlArray.count;
    if (_imageUrlArray.count > 0) {
        UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickTap:)];
        clickTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:clickTap];
    }
    if (countImages == 0 || countImages == 1) {
        countImages = 1;
    }else {
        countImages += 2;
    }
    self.bannerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * countImages, CGRectGetHeight(self.bounds));
    if (countImages > 1) {
        self.pageControl.numberOfPages = _imageUrlArray.count;
        LSKBannerImageView *imageView = nil;
        self.pageControl.currentPage = 0;
        if (countImages > 1) {
            [self.bannerScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)];
            imageView = (LSKBannerImageView *)[self.bannerScrollView.subviews objectAtIndex:1];
        }else {
            [self.bannerScrollView setContentOffset:CGPointZero];
            imageView = (LSKBannerImageView *)self.bannerScrollView.subviews.firstObject;
        }
        [imageView loadWebImageView];
        [self.timer pauseTimer];
        [self.timer resumeTimer:kFGGScrollInterval];
        self.bannerScrollView.scrollEnabled = YES;
    }else {
        if (_pageControl) {
            _pageControl.hidden = YES;
            [_pageControl removeFromSuperview];
            _pageControl = nil;
        }
        if (_timer) {
            [self.timer pauseTimer];
        }
        self.bannerScrollView.scrollEnabled = NO;
    }
}
#pragma mark - kvo
- (void)addObservers {
    [_bannerScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    if (_bannerScrollView) {
        [self.bannerScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self caculateCurIndex];
    }
}

#pragma mark - caculate curIndex
- (void)caculateCurIndex {
    CGFloat width = CGRectGetWidth(self.bounds);
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    int currentPage = self.bannerScrollView.contentOffset.x/width;
    if (currentPage == _imageUrlArray.count + 1) {
        [self.bannerScrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }else if (self.bannerScrollView.contentOffset.x < 10)
    {
        [self.bannerScrollView setContentOffset:CGPointMake(width * (_imageUrlArray.count ), 0) animated:NO];
        self.pageControl.currentPage = _imageUrlArray.count;
    }else
    {
        self.pageControl.currentPage = currentPage - 1;
    }
    LSKBannerImageView *imageView = (LSKBannerImageView *)[self.bannerScrollView.subviews objectAtIndex:currentPage];
    [imageView loadWebImageView];
}
#pragma mark---- UIScrollView delegate methods
//定时器事件
- (void)timerActionClick {
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    int currentPage = self.bannerScrollView.contentOffset.x / pageWidth;
    NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.bannerScrollView.frame.size;
    CGRect rect = CGRectMake((currentPage + 1) * pageWidth, 0, viewSize.width, viewSize.height);
    [self.bannerScrollView scrollRectToVisible:rect animated:YES];
    currPageNumber++;
    if (currentPage  == _imageUrlArray.count + 1) {
        currPageNumber = 0;
    }
    self.pageControl.currentPage = currPageNumber;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer pauseTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        [self.timer resumeTimer:kFGGScrollInterval];
}
-(void)changeIndex
{
    [self.timer pauseTimer];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat heigth = CGRectGetHeight(self.bounds);
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    NSInteger currentPage = self.pageControl.currentPage;
    
    [self.bannerScrollView scrollRectToVisible:CGRectMake(width * (currentPage + 1), 0, width, heigth) animated:YES];
    //拖动完毕的时候 重新开始计时器控制跳转
    
    [self.timer resumeTimer:kFGGScrollInterval];
}

#pragma mark -懒加载界面控件
- (NSTimer *)timer {
    if (!_timer) {
        @weakify(self)
        _timer = [NSTimer initTimerWithTimeInterval:kFGGScrollInterval block:^(NSTimer *timer) {
            @strongify(self)
            [self timerActionClick];
        } repeats:YES runModel:NSRunLoopCommonModes];
    }
    return _timer;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 20, CGRectGetWidth(self.bounds), 20)];
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor= ColorHexadecimal(Color_APP_MAIN, 1.0);
        _pageControl.transform=CGAffineTransformScale(CGAffineTransformIdentity, .7, .7);
        [_pageControl addTarget:self action:@selector(changeIndex)
               forControlEvents:UIControlEventValueChanged];
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _bannerScrollView.delegate = self;
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        [self addObservers];
        [self addSubview:_bannerScrollView];
    }
    return _bannerScrollView;
}

- (void)dealloc {
    [self removeObservers];
    
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
