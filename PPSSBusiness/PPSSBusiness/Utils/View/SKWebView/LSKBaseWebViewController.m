//
//  LSKBaseWebViewController.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseWebViewController.h"
#import "LSKWebView.h"
#import "LSKWebProgressView.h"
#import "UIBarButtonItem+Extend.h"
static const CGFloat kWeb_Progress_View_Height = 4;
static const NSInteger kWeb_Progress_View_Tag = 5001;
@interface LSKBaseWebViewController ()
@property (strong ,nonatomic) LSKWebView *webView;
@property (strong ,nonatomic) UIButton *m_closeButton;
@property (assign ,nonatomic) BOOL isCanBlack;
@property (assign ,nonatomic) BOOL isClickBack;
@property (assign ,nonatomic) BOOL hasClickLink;
@property (assign ,nonatomic) NSInteger firstHistoryCount;
@property (strong ,nonatomic) LSKWebProgressView *progressView;
@end

@implementation LSKBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigationLeftItem];
    [self customMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_progressView) {
        _progressView.hidden = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_progressView) {
        _progressView.hidden = YES;
    }
}
- (void)changeWebFrame:(CGRect)frame {
    [_webView changeFrame:frame];
}

- (void)setLoadStatusBlock:(WebLoadStatusBlock)loadStatusBlock {
    self.webView.loadStatusBlock = loadStatusBlock;
}
- (void)backClick {
    if (self.isShowBack) {
        _isClickBack = YES;
        if ([self.webView canGoBack] && [self.webView historyCount] > self.firstHistoryCount) {
            self.m_closeButton.hidden = NO;
            [self.webView stopLoading];
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
            [self stopLoading];
        }
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self stopLoading];
    }
}
- (void)setTitleBlock:(LSKWebTitleBlock)titleBlock {
    _titleBlock = titleBlock;
    self.webView.webTitleBlock = titleBlock;
}
- (void)stopLoading {
    [self.webView stopLoading];
}

- (BOOL)loadReuqestWithUrl:(NSString *)requestUrl {
    return YES;
}
- (void)loadMainWebViewUrl:(NSString *)url
{
    [self.webView loadWebViewUrl:url];
}
#pragma mark =----
- (void)customMainView {
    self.firstHistoryCount = 0;
    self.webView = [[LSKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
}
#pragma mark 加载导航栏
-(void)setIsShowProgress:(BOOL)isShowProgress
{
    _isShowProgress = isShowProgress;
    if (isShowProgress && !_webView.progressBlock) {
        self.progressView.hidden = NO;
        [self showLoadProgress];
    }
}
- (void)setProgressBlock:(LSKWebProgressBlock)progressBlock {
    if (_progressView == nil) {
        [self showLoadProgress];
    }
    _progressBlock = progressBlock;
}

- (void)showLoadProgress {
    @weakify(self)
    self.webView.progressBlock = ^(CGFloat progress){
        @strongify(self)
        [self progressLoad:progress];
    };
}
- (void)progressLoad:(CGFloat)progress {
    if (self.progressBlock) {
        self.progressBlock(progress);
    }
    if (self.isShowProgress) {
        [self.progressView setProgress:progress];
    }
}
- (LSKWebProgressView *)progressView {
    if (!_progressView) {
        UIView *progress = [self.navigationController.navigationBar viewWithTag:kWeb_Progress_View_Tag];
        if (progress) {
            self.progressView = (LSKWebProgressView *)progress;
            _progressView.hidden = NO;
        }else {
            _progressView = [[LSKWebProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.bounds) - kWeb_Progress_View_Height, SCREEN_WIDTH, kWeb_Progress_View_Height)];
            _progressView.tag = kWeb_Progress_View_Tag;
            [self.navigationController.navigationBar addSubview:_progressView];
        }
        
    }
    return _progressView;
}
#pragma 绑定js交互
-(void)setIsGetJsBrirge:(BOOL)isGetJsBrirge
{
    _isGetJsBrirge = isGetJsBrirge;
    if (_isGetJsBrirge) {
        @weakify(self)
        self.webView.webUrlBlock = ^BOOL(NSString *url,UIWebViewNavigationType navigationType){
            @strongify(self)
            return [self webLoadRequest:url navi:navigationType];
        };
    }
}
-(BOOL)webLoadRequest:(NSString *)url navi:(UIWebViewNavigationType)navigationType
{
    if (self.isShowBack) {
        if (navigationType == UIWebViewNavigationTypeLinkClicked && !self.hasClickLink) {
            self.hasClickLink = YES;
            self.firstHistoryCount = [self.webView historyCount];
        }
        if (!self.hasClickLink) {
            NSString *originUrl = [self.webView originRequest];
            if ([url isEqualToString:originUrl] && _isClickBack) {
                self.m_closeButton.hidden = YES;
                [self.webView stopLoading];
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }else if (![url isEqualToString:originUrl] && _isClickBack) {
                self.m_closeButton.hidden = NO;
            }
        }
        _isClickBack = NO;
    }
    return [self loadReuqestWithUrl:url];
}
-(void)createNavigationLeftItem {
    if (!_m_closeButton) {
        _m_closeButton = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:@"webclose.png" selectedImage:nil target:self action:@selector(closeViewBack) textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
        _m_closeButton.frame = CGRectMake(0, 0, 25, 25);
        _m_closeButton.hidden = YES;
        self.navigationItem.leftBarButtonItem = nil;
        UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_m_closeButton];
        UIBarButtonItem *backButtonItem = [UIBarButtonItem initBarButtonItemWithNornalImage:@"appNavBackBtn" seletedImage:nil title:nil font:0 fontColor:nil target:self action:@selector(backClick)];
        self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem initBarButtonItemSpace],backButtonItem,closeButtonItem];
    }
}
- (void)closeViewBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {
    _progressBlock = nil;
    if (_progressView) {
        _progressView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
