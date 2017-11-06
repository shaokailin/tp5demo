//
//  LSKBaseWebView.m
//  SingleStore
//
//  Created by LSKlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseWebView.h"
#import <WebKit/WebKit.h>
#import "LSKWebEventHandleManager.h"
@interface LSKBaseWebView ()  <WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) NSInteger titleChangeCount;
@property (nonatomic, strong) LSKWebEventHandleManager *eventHandle;
@end
@implementation LSKBaseWebView
#pragma mark - 界面的相关初始化内容
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_MAIN_HEIGHT)];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleChangeCount = 0;
        [self _initWithWebView];
    }
    return self;
}
//修改界面的宽高
-(void)changeWebViewFrame :(CGRect)rect {
    [self setFrame:rect];
    [self.wkWebView setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
}
- (void)_initWithWebView {
    //webview 配置
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    
    WKPreferences* preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10;
    configuration.preferences = preferences;
    
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    _wkWebView = webView;
    [self addSubview:_wkWebView];
}

#pragma mark - WKNavigationDelegate 跟webview 一样
///判断当前加载的url是否是WKWebView不能打开的协议类型
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL*)url
{
    BOOL retValue = NO;
    //判断是否正在加载WKWebview不能识别的协议类型：phone numbers, email address, maps, etc.
    if ([url.scheme isEqualToString:@"tel"]) {
        UIApplication* app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            [app openURL:url];
            retValue = YES;
        }
    }
    return retValue;
}
//判断是否可以加载
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    BOOL isLoadingDisableScheme = [self isLoadingWKWebViewDisableScheme:navigationAction.request.URL];
    
    if (resultBOOL && !isLoadingDisableScheme) {
        self.currentRequest = navigationAction.request;
        if (navigationAction.targetFrame == nil) {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
- (void)webView:(WKWebView*)webView didStartProvisionalNavigation:(WKNavigation*)navigation
{
    [self callback_webViewDidStartLoad];
}
// 当main frame导航完成时，会回调
- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation
{
    [self callback_webViewDidFinishLoad];
}
// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView*)webView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    [self callback_webViewDidFailLoadWithError:error];
}
// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView*)webView didFailNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    [self callback_webViewDidFailLoadWithError:error];
}
//重定向
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
#pragma mark - WKUIDelegate

// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"100===%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:
                      UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                          completionHandler();
                      }]];
    //    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"101===%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:
                                @"confirm" message:@"JS调用confirm"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                                                  completionHandler(YES);
                                              }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                  completionHandler(NO);
                                              }]];
    //    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}


// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView
runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(nullable NSString *)defaultText
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"102===%s", __FUNCTION__);
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:
                                prompt message:defaultText
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                  completionHandler([[alert.textFields lastObject] text]);
                                              }]];
    //    [self presentViewController:alert animated:YES completion:NULL];
}

///--  还没用到
#pragma mark - CALLBACK WebView Delegate

- (void)callback_webViewDidFinishLoad
{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)callback_webViewDidStartLoad
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)callback_webViewDidFailLoadWithError:(NSError*)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}
- (BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType
{
    BOOL resultBOOL = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        if (navigationType == -1) {
            navigationType = UIWebViewNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}
#pragma mark - 监听加载进度 和 标题
- (void)setProgressBlock:(LSKWebProgressBlock)progressBlock {
    if (progressBlock != nil) {
        _progressBlock = progressBlock;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
}
- (void)setTitleBlock:(LSKWebTitleBlock)titleBlock {
    if (titleBlock != nil) {
        _titleBlock = titleBlock;
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        if (self.progressBlock) {
            self.progressBlock(self.estimatedProgress);
        }
    }
    else if ([keyPath isEqualToString:@"title"]) {
        self.title = change[NSKeyValueChangeNewKey];
        self.titleChangeCount ++;
        if (self.titleBlock) {
            self.titleBlock(self.title);
        }
    }
}
#pragma mark - 基础方法
- (NSInteger)countOfHistory {
    return _wkWebView.backForwardList.backList.count;
}
- (UIScrollView*)scrollView {
    return [_wkWebView scrollView];
}
- (id)loadRequest:(NSURLRequest*)request {
    if (self.originRequest == nil) {
        self.originRequest = request;
    }
    self.currentRequest = request;
    return [_wkWebView loadRequest:request];
}
- (id)loadHTMLString:(NSString*)string baseURL:(NSURL*)baseURL {
    return [_wkWebView loadHTMLString:string baseURL:baseURL];
}
- (NSURLRequest*)currentRequest {
    return _currentRequest;
}
- (NSURL*)URL {
    return [_wkWebView URL];
}
- (BOOL)isLoading {
    return [_wkWebView isLoading];
}
- (BOOL)canGoBack {
    return [_wkWebView canGoBack];
}
- (BOOL)canGoForward {
    return [_wkWebView canGoForward];
}
- (id)goBack {
    return [_wkWebView goBack];
}
- (id)goForward {
    return [_wkWebView goForward];
}
- (id)reload {
    return [_wkWebView reload];
}
- (id)reloadFromOrigin {
    return [_wkWebView reloadFromOrigin];
}
- (void)stopLoading {
    [self.wkWebView stopLoading];
}
- (void)gobackWithStep:(NSInteger)step {
    if (self.canGoBack == NO)
        return;
    if (step > 0) {
        NSInteger historyCount = self.countOfHistory;
        if (step >= historyCount) {
            step = historyCount - 1;
        }
        WKBackForwardListItem* backItem = _wkWebView.backForwardList.backList[step];
        [_wkWebView goToBackForwardListItem:backItem];
    }
    else {
        [self goBack];
    }
}
#pragma mark js - oc  交互
- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler
{
    return [self.wkWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
//是否需要JS交互
- (void)setIsCanJsCallObject:(BOOL)isCanJsCallObject {
    _isCanJsCallObject = isCanJsCallObject;
    if (isCanJsCallObject) {
        [self addScriptMessageHandelWithName:WebEventHandle];
    }
}

- (void)addScriptMessageHandelWithName:(NSString *)name {
    WKWebViewConfiguration* configuration = [_wkWebView configuration];
    if (configuration.userContentController == nil) {
        configuration.userContentController = [WKUserContentController new];
    }
    [configuration.userContentController addScriptMessageHandler:self.eventHandle name:name];
}
- (LSKWebEventHandleManager *)eventHandle {
    if (!_eventHandle) {
        _eventHandle = [[LSKWebEventHandleManager alloc] init];
        _eventHandle.webView = _wkWebView;
    }
    return _eventHandle;
}

#pragma mark - 清理
- (void)dealloc
{
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
    if (_progressBlock) {
        [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    if (_titleBlock) {
        [_wkWebView removeObserver:self forKeyPath:@"title"];
    }
//    [_wkWebView removeObserver:self forKeyPath:@"loading"];
    [_wkWebView scrollView].delegate = nil;
    [_wkWebView stopLoading];
    [_wkWebView removeFromSuperview];
    _wkWebView = nil;
}

@end
