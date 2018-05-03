//
//  AppDelegate.h
//  LotteryCharts
//
//  Created by lsk on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@property (strong, nonatomic) UIWindow *window;
- (void)changeLoginState;
- (void)loginOutEvent;
@end

