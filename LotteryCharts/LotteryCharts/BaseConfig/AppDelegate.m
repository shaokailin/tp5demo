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
    return YES;
}
- (void)windowRootController {
    self.window.rootViewController = self.rootTabBarVC;
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
