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
@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, strong) PPSSRootTabBarVC *rootTabBarVC;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置导航栏的全局样式
    [LSKViewFactory setupMainNavigationBgColor:ColorUtilsString(kNavigationBackground_Color) titleFont:kNavigationTitle_Font titleColor:ColorUtilsString(kNavigationTitle_Color) lineColor:ColorUtilsString(kNavigationLine_Color)];
    //根据是否有登录来初始化root 控制器
    [self windowRootControllerChange:YES];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)windowRootControllerChange:(BOOL)isLogin {
    if (isLogin) {
        self.window.rootViewController = self.rootTabBarVC;
    }else {
        PPSSLoginMainVC *loginVC = [[PPSSLoginMainVC alloc]init];
        UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginNavi;
    }
}
- (PPSSRootTabBarVC *)rootTabBarVC {
    if (!_rootTabBarVC) {
        _rootTabBarVC = [[PPSSRootTabBarVC alloc]init];
    }
    return _rootTabBarVC;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
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
