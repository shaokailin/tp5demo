//
//  LSKBaseWebView.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSKWebViewConfig.h"
@protocol WKScriptMessageHandler;
@class LSKBaseWebView,WKWebView;

@protocol LSKBaseWebViewDelegate <NSObject>
@optional
//开始加载
- (void)webViewDidStartLoad:(LSKBaseWebView *)webView;
//加载成功结束
- (void)webViewDidFinishLoad:(LSKBaseWebView *)webView;
//加载失败
- (void)webView:(LSKBaseWebView *)webView didFailLoadWithError:(NSError*)error;
//地址是否继续加载
- (BOOL)webView:(LSKBaseWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;

@end

@interface LSKBaseWebView : UIView
@property (nonatomic, assign) BOOL isCanJsCallObject;
///预估网页加载进度
@property (nonatomic, readonly) double estimatedProgress;
//当前页面title
@property (nonatomic, readonly, copy) NSString *title;

///会转接 WKUIDelegate，WKNavigationDelegate 内部未实现的回调。
@property (weak, nonatomic) id<LSKBaseWebViewDelegate> delegate;
//是否需要获取进度
@property (nonatomic, copy) LSKWebProgressBlock progressBlock;

@property (nonatomic, copy) LSKWebTitleBlock titleBlock;
//原请求
@property (nonatomic, readonly) NSURLRequest* originRequest;

//修改界面的大小
-(void)changeWebViewFrame :(CGRect)rect;

///back 层数
- (NSInteger)countOfHistory;
//跳转到第几
- (void)gobackWithStep:(NSInteger)step;

///---- UI 或者 WK 的API
@property (nonatomic, readonly) UIScrollView *scrollView;
//加载请求
- (id)loadRequest:(NSURLRequest *)request;
//加载html 内容
- (id)loadHTMLString:(NSString*)string baseURL:(NSURL*)baseURL;
//当前的请求
@property (nonatomic, readonly) NSURLRequest *currentRequest;
//当前的URL
@property (nonatomic, readonly) NSURL *URL;
//是否在加载
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
//是否可以返回
@property (nonatomic, readonly) BOOL canGoBack;
//是否可以前进
@property (nonatomic, readonly) BOOL canGoForward;
//返回
- (id)goBack;
//前进
- (id)goForward;
//重新加载
- (id)reload;
//重新加载
- (id)reloadFromOrigin;
//停止加载
- (void)stopLoading;
/**
 调用JS
 
 @param javaScriptString 要调用的方法
 @param completionHandler 返回内容和错误
 */
- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;
///WKWebView 跟网页进行交互的方法。
- (void)addScriptMessageHandelWithName:(NSString*)name;
@end
