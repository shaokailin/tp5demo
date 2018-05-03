//
//  Created by linshaokai on 2016/9/30.
//  Copyright © 2016年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SKHUD : UIView
//显示消息提示
+ (void)showMessageInView:(UIView *)view  withMessage:(NSString *)message;
+ (void)showMessageInWindowWithMessage:(NSString *)message;
//显示网络失败
+ (void)showNetworkErrorMessageInView:(UIView *)view;

+ (void)showNetworkPostErrorMessageInView:(UIView *)view;
//点的网络加载框
+ (void)showLoadingDotInView:(UIView *)view;
+ (void)showLoadingDotInWindow;
+(void)showLoadingDotInView:(UIView *)view withMessage:(NSString*)message;
+ (void)showLoadingDotInWindowWithMessage:(NSString *)message;
//取消加载框
+ (void)dismiss;

@end
