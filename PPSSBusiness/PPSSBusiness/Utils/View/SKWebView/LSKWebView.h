//
//  LSKWebView.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSKWebViewConfig.h"
@interface LSKWebView : UIView
@property (nonatomic, copy) LSKWebTitleBlock webTitleBlock;
@property (nonatomic, copy) WebUrlBlock webUrlBlock;
@property (nonatomic, copy) WebLoadStatusBlock loadStatusBlock;
@property (nonatomic, copy) LSKWebProgressBlock progressBlock;
//修改界面的大小
- (void)changeFrame:(CGRect)rect;
//加载url
-(void)loadWebViewUrl:(NSString *)url;
//加载request
-(void)loadWebViewUrlRequest:(NSURLRequest *)requestUrl;
//获取首个地址
- (NSString *)originRequest;
// 浏览历史个数
- (NSInteger)historyCount;
//可以返回判断
- (BOOL)canGoBack;
//返回
- (void)goBack;
//前进
- (void)goForward;
//重新加载
- (void)reload;
//重新加载原地址
- (void)reloadFromOrigin;
//停止加载
- (void)stopLoading;
@end
