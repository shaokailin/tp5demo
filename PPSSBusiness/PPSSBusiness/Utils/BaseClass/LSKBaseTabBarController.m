//
//  LSKBaseTabBarController.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseTabBarController.h"
#import "UITabBarController+Extend.h"
static NSString * const kTabBarViewController_Plist = @"TabBarSetting";

@interface LSKBaseTabBarController ()

@end

@implementation LSKBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置tabbar的背景颜色
    [self setupTabBarBackgroundColor:KColorUtilsString(kTabBarBackground_Color)];
    //设置tabbar的标题 字体样式
    [self setupTabbarNornalTitleColor:KColorUtilsString(kTabBarTitleNornal_Color) tabbarSelectdTitleColor:KColorUtilsString(kTabBarTitleSelected_Color) tabbarTitleFont:kTabBarTitle_Font];
    //设置tabbar的viewcontroller
    NSArray *tabBarSettingArray = [NSArray arrayWithPlist:kTabBarViewController_Plist];
    if (tabBarSettingArray.count > 0) {
        NSMutableArray *viewControllers = [NSMutableArray array];
        for (NSDictionary *settingDic in tabBarSettingArray) {
            @autoreleasepool {
            UINavigationController *navigationController = [self initializeNavigationWithClass:[settingDic objectForKey:@"class_name"] naviTitle:[settingDic objectForKey:@"navigation_title"] tabbarTitle:[settingDic objectForKey:@"tabbar_title"]  tabbarNornalImage:[settingDic objectForKey:@"nornal_img"] tabbarSeletedImage:[settingDic objectForKey:@"selected_img"]];
                [viewControllers addObject:navigationController];
            }
        }
        self.viewControllers = viewControllers;
    }
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
