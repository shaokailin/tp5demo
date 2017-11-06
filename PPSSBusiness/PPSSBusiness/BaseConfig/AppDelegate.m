//
//  AppDelegate.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/7.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "PPSSRootTabBarVC.h"
#import "PPSSLoginMainVC.h"
#import "PPSSAppVersionManager.h"
#import "JPUSHService.h"
#import "UMMobClick/MobClick.h"
#import <AVFoundation/AVFoundation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "PPSSSpeechManager.h"
#endif
#import <AdSupport/AdSupport.h>
#import <UMSocialCore/UMSocialCore.h>
#import "PPSSWebVC.h"
static NSString * const kJPushAppKey = @"8b317ffe11b4320086ffa968";
static NSString * const kUMengiPhoneKey = @"59eee6daf29d9823e9000090";
static NSString * const kQQAppId = @"1106498102";
//static NSString * const kQQAppKey = @"Jry3jpsFMooSR9FY";
static NSString * const kWXAppId = @"wx33a4485684cbba53";
static NSString * const kWXAppSecret = @"7e4fb3d60ae074fbd98421be0a7fd7cf";
static const NSInteger isProduction = false;
static NSString * const kAppChannel = @"App Store";
@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic, strong) PPSSRootTabBarVC *rootTabBarVC;
@property (nonatomic, strong) PPSSAppVersionManager *appVersionManager;
@property (nonatomic, strong) PPSSSpeechManager *speachManager;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self registerAPNs:launchOptions];
    [self registerUMAnalytics];
    //设置导航栏的全局样式
    [LSKViewFactory setupMainNavigationBgColor:KColorUtilsString(kNavigationBackground_Color) titleFont:kNavigationTitle_Font titleColor:KColorUtilsString(kNavigationTitle_Color) lineColor:KColorUtilsString(kNavigationLine_Color)];
    //根据是否有登录来初始化root 控制器
    [self windowRootControllerChange:[KUserMessageManager isLogin]];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)changeUserPower {
    if (_rootTabBarVC) {
        [self.rootTabBarVC editTabBarForPower:[KUserMessageManager.power integerValue]];
    }
}
- (void)windowRootControllerChange:(BOOL)isLogin {
    if (isLogin) {
        self.window.rootViewController = self.rootTabBarVC;
        [self changeUserPower];
        [KUserMessageManager isHasRegisterAlias];
    }else {
        PPSSLoginMainVC *loginVC = [[PPSSLoginMainVC alloc]init];
        loginVC.inType = LoginMainInType_Nornal;
        UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginNavi;
        [KUserMessageManager cleanAlias];
    }
}
- (PPSSRootTabBarVC *)rootTabBarVC {
    if (!_rootTabBarVC) {
        _rootTabBarVC = [[PPSSRootTabBarVC alloc]init];
    }
    return _rootTabBarVC;
}
- (void)delectFontSettingTabbar {
    self.rootTabBarVC = nil;
}
#pragma mark -版本更新
- (PPSSAppVersionManager *)appVersionManager {
    if (!_appVersionManager) {
        _appVersionManager = [[PPSSAppVersionManager alloc]init];
    }
    return _appVersionManager;
}
#pragma mark - 友盟统计
- (void)registerUMAnalytics {
    UMConfigInstance.appKey = kUMengiPhoneKey;
    UMConfigInstance.channelId = kAppChannel;
    [MobClick setAppVersion:[LSKPublicMethodUtil getAppVersion]];
    [MobClick setCrashReportEnabled:NO];
    [MobClick startWithConfigure:UMConfigInstance];
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMengiPhoneKey];
    [self configUSharePlatforms];
}
- (void)configUSharePlatforms {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWXAppId appSecret:kWXAppSecret redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppId  appSecret:nil redirectURL:@"http://www.huashengplan.com"];
}

#pragma mark 推送
- (void)registerAPNs:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    entity.categories = [self addPushCategory];
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingIdentifer =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
                          channel:kAppChannel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingIdentifer];
}
- (NSSet *)addPushCategory {
    NSSet *categories = nil;
    if (@available(iOS 10.0, *)) {
        NSSet<UNNotificationCategory *> *categories2;
        categories = categories2;
    } else {
        NSSet<UIUserNotificationCategory *> *categories2;
        categories = categories2;
    }
    return categories;
}

//获取到token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
//获取失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//回调。分享
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    [self setupBackgroundSound];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [application beginReceivingRemoteControlEvents];  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.appVersionManager loadAppVersion];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}
#pragma mark 推送消息接收
//用于静默推送
//&& [[apns objectForKey:@"content-available"] integerValue] == 1 && [UIApplication sharedApplication].applicationState == 2
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([LSKPublicMethodUtil getiOSSystemVersion] >= 10) {
        NSDictionary *apns = [userInfo objectForKey:@"aps"];
        if (apns && [[apns objectForKey:@"content-available"] integerValue] != 1 && (!KJudgeIsNullData([apns objectForKey:@"sound"]) || (!KJudgeIsNullData([apns objectForKey:@"alert"])))) {
            [self handleRemoteNotificationForcegroundWithUserInfo:userInfo withCancle:@"didReceive"];
            completionHandler(UIBackgroundFetchResultNewData);
        }else {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    }else {
        [self handleRemoteNotificationForcegroundWithUserInfo:userInfo withCancle:@"didReceive"];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//ios10之前的
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self handleRemoteNotificationForcegroundWithUserInfo:userInfo withCancle:@"did7"];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#pragma mark- JPUSHRegisterDelegate
//用于前台运行
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSDictionary *dict = content.userInfo;
            BOOL isSound = [self handleRemoteNotificationForcegroundWithUserInfo:dict withCancle:@"will10"];
            if (isSound) {
                completionHandler(UNNotificationPresentationOptionBadge);
                return;
            }
        }
        else {
            // 判断为本地通知didReceiveRemoteNotification
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
       
    }
}
//用于后台及程序退出 指的是程序正在运行中, 用户能看见程序的界面. iOS10会出现通知横幅, 而在以前的框架中, 前台运行时, 不会出现通知的横幅.
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = response.notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [self handleRemoteNotificationForcegroundWithUserInfo:content.userInfo withCancle:@"did10"];
        }
        else {
        }
    } else {}
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (BOOL)handleRemoteNotificationForcegroundWithUserInfo:(NSDictionary *)userInfo withCancle:(NSString *)cancle {
    [JPUSHService handleRemoteNotification:userInfo];
    NSInteger type = [[userInfo objectForKey:@"type"]integerValue];
    if (type != 0) {
        NSDictionary *apns = [userInfo objectForKey:@"aps"];
        NSString *title = [apns objectForKey:@"alert"];
        NSInteger state = [UIApplication sharedApplication].applicationState;
        if (state == 0 && type == 1) {
            if (![KUserMessageManager getMessageManagerForBoolWithKey:kSystemNoticeSetting_Voice]) {
                [self.speachManager readLast:title];
                return YES;
            }else {
                return NO;
            }
        }else if (type == 2){
            LSKLog(@"%ld",(long)[UIApplication sharedApplication].applicationState);
            NSString *content = [userInfo objectForKey:@"content"];
            if (_rootTabBarVC && KUserMessageManager.isLogin && KJudgeIsNullData(content)) {
                if (state == 0 && ![cancle isEqualToString:@"did10"]) {
                    if ([LSKPublicMethodUtil getiOSSystemVersion] < 10) {
                        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"收到消息" message:title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去查看", nil];
                        @weakify(self)
                        [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
                            if ([x integerValue] == 1) {
                                @strongify(self)
                                [self jumpWebView:title url:content];
                            }
                            [KUserMessageManager hidenAlertView];
                        }];
                        [KUserMessageManager showAlertView:alterView weight:3];
                    }
                }else if([cancle isEqualToString:@"did10"] ) {
                    [self jumpWebView:title url:content];
                }
            }
        }
    }
    return NO;
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url {
    UINavigationController *navi = _rootTabBarVC.selectedViewController;
    PPSSWebVC *web = [[PPSSWebVC alloc]init];
    web.titleString = title;
    web.loadUrl = url;
    if (navi.viewControllers.count == 1) {
        web.hidesBottomBarWhenPushed = YES;
    }
    [navi pushViewController:web animated:YES];
}
- (PPSSSpeechManager *)speachManager {
    if (!_speachManager) {
        _speachManager = [[PPSSSpeechManager alloc]init];
    }
    return _speachManager;
}
@end
