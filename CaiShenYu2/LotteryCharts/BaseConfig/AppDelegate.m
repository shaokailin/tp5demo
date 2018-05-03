//
//  AppDelegate.m
//  LotteryCharts
//
//  Created by lsk on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "AppDelegate.h"
#import "LCRootTabBarVC.h"
#import "LCLoginMainVC.h"
#import "LCUserMainVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import "LCPayResultHandle.h"
#import "FSDateTool.h"
#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "WelcomeView.h"

@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, strong) LCRootTabBarVC *rootTabBarVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置导航栏的全局样式
    [LSKViewFactory setupMainNavigationBgColor:KColorUtilsString(kNavigationBackground_Color) titleFont:kNavigationTitle_Font titleColor:KColorUtilsString(kNavigationTitle_Color) lineColor:KColorUtilsString(kNavigationLine_Color)];
    [self windowRootController];
    [self.window makeKeyAndVisible];
    [self setupUmengConfig];
    return YES;
}
- (void)setupUmengConfig {
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a7cf6f7b27b0a5ff9000609"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7896e36017349dfb" appSecret:@"0c8bbf3f22537e87367539f1e16b238b" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106477215"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [WXApi registerApp:@"wx7896e36017349dfb"];
}
- (void)windowRootController {
    NSInteger timeSort = [FSDateTool compareCurrentDateWith:@"2018-4-1 19:00:00"];
    if (timeSort == 1) {
        self.window.rootViewController = self.rootTabBarVC;
    }else {
        //原生
        //创建首页
        HomeViewController *mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
        LeftMenuViewController *leftVC = [[LeftMenuViewController alloc] init];
        self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
        
        //欢迎页
        WelcomeView *welcome = [[WelcomeView alloc] init];
        self.window.rootViewController = welcome;
    }
}
- (void)changeLoginState {
//    [self.rootTabBarVC changeLoginWithState];
    self.rootTabBarVC.selectedIndex = 0;
}
- (LCRootTabBarVC *)rootTabBarVC {
    if (!_rootTabBarVC) {
        _rootTabBarVC = [[LCRootTabBarVC alloc]init];
        _rootTabBarVC.delegate = self;
    }
    return _rootTabBarVC;
}
- (void)loginOutEvent {
    UINavigationController *selectNavi = (UINavigationController *)self.rootTabBarVC.selectedViewController;
    LCLoginMainVC *login = [[LCLoginMainVC alloc]init];
    login.isHidenNavi = YES;
    login.hidesBottomBarWhenPushed = YES;
    [selectNavi pushViewController:login animated:YES];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController *navi = (UINavigationController *)viewController;
    if (![kUserMessageManager isLogin] && [navi.topViewController isKindOfClass:[LCUserMainVC class]]) {
        UINavigationController *selectNavi = (UINavigationController *)self.rootTabBarVC.selectedViewController;
        LCLoginMainVC *login = [[LCLoginMainVC alloc]init];
        login.isHidenNavi = YES;
        login.hidesBottomBarWhenPushed = YES;
        [selectNavi pushViewController:login animated:YES];
        return NO;
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            LSKLog(@"result = %@",resultDic);
            NSInteger code = [[resultDic objectForKey:@"resultStatus"]integerValue];
            if (code == 9000) {
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Success_Notice object:nil];
            }else {
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Fail_Notice object:nil];
            }
        }];
    }else {
        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        if (!result) {
            return [WXApi handleOpenURL:url delegate:[LCPayResultHandle sharedManager]];
        }
        return result;
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            LSKLog(@"result = %@",resultDic);
            NSInteger code = [[resultDic objectForKey:@"resultStatus"]integerValue];
            if (code == 9000) {
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Success_Notice object:nil];
            }else {
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Fail_Notice object:nil];
            }
        }];
    }else{
        BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
        if (!result) {
            return [WXApi handleOpenURL:url delegate:[LCPayResultHandle sharedManager]];
        }
        return result;
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
