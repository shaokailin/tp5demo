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
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "LCUserMessageListVC.h"
@interface AppDelegate ()<UITabBarControllerDelegate,JPUSHRegisterDelegate>
@property (nonatomic, strong) LCRootTabBarVC *rootTabBarVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置导航栏的全局样式
    [LSKViewFactory setupMainNavigationBgColor:KColorUtilsString(kNavigationBackground_Color) titleFont:kNavigationTitle_Font titleColor:KColorUtilsString(kNavigationTitle_Color) lineColor:KColorUtilsString(kNavigationLine_Color)];
    [self windowRootController];
    [self registerAPNs:launchOptions];
    [self.window makeKeyAndVisible];
    [self setupUmengConfig];
    return YES;
}
- (void)registerAPNs:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    //    entity.categories = [self addPushCategory];
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingIdentifer =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:@"127861ec22f197cf5b1bdb10"
                          channel:@"APP Store"
                 apsForProduction:NO
            advertisingIdentifier:advertisingIdentifer];
}
- (void)setupUmengConfig {
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a7cf6f7b27b0a5ff9000609"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7896e36017349dfb" appSecret:@"0c8bbf3f22537e87367539f1e16b238b" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106477215"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [WXApi registerApp:@"wx7896e36017349dfb"];
}
- (void)windowRootController {
    self.window.rootViewController = self.rootTabBarVC;
    if (kUserMessageManager.login) {
        [kUserMessageManager isHasRegisterAlias];
    }else {
        [kUserMessageManager cleanAlias];
    }
    
}
- (void)changeLoginState {
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    LSKLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//            NSDictionary *dict = content.userInfo;
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
        [JPUSHService handleRemoteNotification:content.userInfo];
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        
    }
}
//用于后台及程序退出 指的是程序正在运行中, 用户能看见程序的界面. iOS10会出现通知横幅, 而在以前的框架中, 前台运行时, 不会出现通知的横幅.
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = response.notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [self handleRemoteNotificationForcegroundWithUserInfo:content.userInfo withCancle:@"did10"];
        }
        else {
        }
        completionHandler(UNNotificationPresentationOptionAlert); 
    } else {
        
    }
     // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self handleRemoteNotificationForcegroundWithUserInfo:userInfo withCancle:@"didReceive"];
    completionHandler(UIBackgroundFetchResultNewData);
}
//静默推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self handleRemoteNotificationForcegroundWithUserInfo:userInfo withCancle:@"did7"];
}
- (NSInteger)handleRemoteNotificationForcegroundWithUserInfo:(NSDictionary *)userInfo withCancle:(NSString *)cancle {
    [JPUSHService handleRemoteNotification:userInfo];
    if (_rootTabBarVC) {
        NSString *userId = [userInfo objectForKey:@"uid"];
        if (KJudgeIsNullData(userId) && kUserMessageManager.isLogin && [kUserMessageManager.userId isEqualToString:userId]) {
            NSInteger type = [[userInfo objectForKey:@"type"] integerValue];
            NSInteger selectIndex = 0;
            if (type >= 100) {
                selectIndex = 1;
            }
            UINavigationController *navi = _rootTabBarVC.selectedViewController;
            UIViewController *controll = navi.topViewController;
            if (![controll isKindOfClass:[LCUserMessageListVC class]]) {
                LCUserMessageListVC *bless = [[LCUserMessageListVC alloc]init];
                if (navi.viewControllers.count == 1) {
                    bless.hidesBottomBarWhenPushed = YES;
                }
                [bless selectIndex:1];
                [navi pushViewController:bless animated:YES];
            }else {
                LCUserMessageListVC *bless = (LCUserMessageListVC *)controll;
                [bless selectIndex:1];
                [bless reloadIndex];
            }
            
        }
    }
    return NO;
}
@end
