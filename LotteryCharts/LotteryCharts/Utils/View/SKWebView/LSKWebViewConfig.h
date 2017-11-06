//
//  LSKWebViewConfig.h
//  SingleStore
//
//  Created by LSKlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#ifndef LSKWebViewConfig_h
#define LSKWebViewConfig_h

/**
 加载进度Block

 @param progress 进度值0-1
 */
typedef void (^LSKWebProgressBlock) (CGFloat progress);

/**
 获取当前加载界面的标题

 @param title 标题
 */
typedef void (^LSKWebTitleBlock) (NSString *title);

/**
 是否允许请求当前的http地址

 @param requestUrl 当前的http地址
 @param navigationType 当前web加载的类型
 @return yes 允许继续
 */
typedef BOOL (^WebUrlBlock) (NSString *requestUrl,UIWebViewNavigationType navigationType);

/**
 加载的最终状态

 @param status 1.开始 2.成功 3.失败
 */
typedef void (^WebLoadStatusBlock)(NSInteger status);

#endif /* LSKWebViewConfig_h */
