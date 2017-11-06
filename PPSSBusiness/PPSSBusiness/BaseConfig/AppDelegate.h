//
//  AppDelegate.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/7.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//是否登录切换
- (void)windowRootControllerChange:(BOOL)isLogin;
- (void)delectFontSettingTabbar;
//权限等级变化
- (void)changeUserPower;
@end

