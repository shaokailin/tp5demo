//
//  LSKBaseWebViewController.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
#import "LSKWebViewConfig.h"
@interface LSKBaseWebViewController : LSKBaseViewController
//是否需要js交互
@property (assign ,nonatomic,readwrite) BOOL isGetJsBrirge;
//是否需要返回出现关闭按钮
@property (assign ,nonatomic,readwrite) BOOL isShowBack;
//获取web的title
@property (copy ,nonatomic,readwrite) LSKWebTitleBlock titleBlock;
//是否在导航栏加进度条
@property (assign ,nonatomic) BOOL isShowProgress;
@property (copy ,nonatomic) LSKWebProgressBlock progressBlock;
@property (copy ,nonatomic) WebLoadStatusBlock loadStatusBlock;
//结束请求
-(void)stopLoading;
//一定要实现的，是为了避免多次点击出现问题  有跳转界面didappear 也要写 ，js交互完都要调用
//-(void)cleanSaveClickUrl;
//加载web url；
-(void)loadMainWebViewUrl:(NSString *)url;
//js 交互需要调用 进行判断交互
-(BOOL)loadReuqestWithUrl:(NSString *)requestUrl;

-(void)changeWebFrame:(CGRect)frame;
@end
