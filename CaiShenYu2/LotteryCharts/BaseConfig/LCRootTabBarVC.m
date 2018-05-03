//
//  LCRootTabBarVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRootTabBarVC.h"
#import "LCUserMainVC.h"
#import "LCLoginMainVC.h"
#import "UITabBarController+Extend.h"
@interface LCRootTabBarVC (){
    BOOL _currentLogin;
}
@property (nonatomic, strong) UINavigationController *loginNavigation;
@property (nonatomic, strong) UINavigationController *userNavigation;
@end

@implementation LCRootTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentLogin = YES;
//    [self changeLoginWithState];
    self.selectedIndex = 0;
}
- (void)changeLoginWithState {
    BOOL loginState = kUserMessageManager.isLogin;
    if (!loginState && loginState != _currentLogin) {
        UINavigationController *controller = [self.viewControllers objectAtIndex:2];
        if (controller) {
            self.userNavigation = controller;
        }
        [self changeThirdTabbar:self.loginNavigation];
    }else if (loginState && _currentLogin != loginState) {
        UINavigationController *controller = [self.viewControllers objectAtIndex:2];
        if (controller) {
            self.loginNavigation = controller;
        }
        [self changeThirdTabbar:self.userNavigation];
    }
    _currentLogin = loginState;
}

- (void)changeThirdTabbar:(UINavigationController *)navi {
    NSMutableArray *controllers = [self.viewControllers mutableCopy];
    [controllers replaceObjectAtIndex:2 withObject:navi];
    self.viewControllers = controllers;
}

- (UINavigationController *)loginNavigation {
    if (!_loginNavigation) {
        _loginNavigation = [self initializeNavigationWithClass:@"LCLoginMainVC" naviTitle:@"登录" tabbarTitle:@"我的" tabbarNornalImage:@"me_nornal" tabbarSeletedImage:@"me_select"];
        
    }
    return _loginNavigation;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
