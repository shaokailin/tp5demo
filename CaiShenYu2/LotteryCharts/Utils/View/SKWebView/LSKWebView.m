//
//  LSKWebView.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKWebView.h"
#import "LSKBaseWebView.h"
@interface LSKWebView ()<LSKBaseWebViewDelegate>
@property (nonatomic, strong) LSKBaseWebView *baseWebView;
@end
@implementation LSKWebView
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _baseWebView = [[LSKBaseWebView alloc]initWithFrame:self.bounds];
        _baseWebView.delegate = self;
        [self addSubview:_baseWebView];
    }
    return self;
}
#pragma mark - public method
- (void)changeFrame:(CGRect)rect {
    self.frame = rect;
    [_baseWebView changeWebViewFrame:rect];
}

- (void)loadWebViewUrl:(NSString *)url {
    if (KJudgeIsNullData(url)) {
        [self.baseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

- (NSInteger)historyCount {
    return [self.baseWebView countOfHistory];
}

- (NSString *)originRequest {
    return self.baseWebView.originRequest.URL.absoluteString;
}

- (BOOL)canGoBack {
    return [self.baseWebView canGoBack];
}
- (void)loadWebViewUrlRequest:(NSURLRequest *)requestUrl {
    [self.baseWebView loadRequest:requestUrl];
}
- (void)goBack {
    [self.baseWebView goBack];
}
- (void)goForward {
    [self.baseWebView goForward];
}
- (void)reload {
    [self.baseWebView reload];
}
- (void)reloadFromOrigin {
    [self.baseWebView reloadFromOrigin];
}
- (void)stopLoading {
    [self.baseWebView stopLoading];
}

- (void)setWebTitleBlock :(LSKWebTitleBlock)webTitleBlock {
    self.baseWebView.titleBlock = webTitleBlock;
}

- (void)setProgressBlock :(LSKWebProgressBlock)progressBlock {
    self.baseWebView.progressBlock = progressBlock;
}

#pragma mark - webbase delegate
- (void)webViewDidStartLoad:(LSKBaseWebView *)webView {
    [self loadStatusChange:1];
}
- (BOOL)webView:(LSKBaseWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.webUrlBlock) {
        NSString *url = [[request URL] absoluteString];
        BOOL isLoading = self.webUrlBlock(url,navigationType);
        return isLoading;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(LSKBaseWebView *)webView
{
    [self loadStatusChange:2];
}
- (void)webView:(LSKBaseWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self performSelector:@selector(loadFail) withObject:nil afterDelay:2.0];
}
- (void)loadFail
{
    [self loadStatusChange:3];
}
- (void)loadStatusChange:(NSInteger)status {
    if (self.loadStatusBlock) {
        self.loadStatusBlock(status);
    }
}


@end
