//
//  AppDelegate.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/2/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *appKey = @"af5316a7b7e84c865b0bfbab";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

