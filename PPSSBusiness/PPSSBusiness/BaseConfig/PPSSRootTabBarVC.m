//
//  PPSSRootTabBarVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSRootTabBarVC.h"
#import "UITabBarController+Extend.h"
static NSString * const kUserTabBarMessageName = @"UserTabBarSetting";
@interface PPSSRootTabBarVC ()
@end
@implementation PPSSRootTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)editTabBarForPower:(NSInteger)power {
    NSInteger hasCount = 3;
    if (power == 2) {
        hasCount = 2;
    }
    if (self.viewControllers.count != hasCount) {
        NSMutableArray *viewController = [self.viewControllers mutableCopy];
        if (self.viewControllers.count < hasCount) {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:kUserTabBarMessageName ofType:@"plist"];
            NSDictionary *settingDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
            UINavigationController *navigationController = [self initializeNavigationWithClass:[settingDic objectForKey:@"class_name"] naviTitle:[settingDic objectForKey:@"navigation_title"] tabbarTitle:[settingDic objectForKey:@"tabbar_title"]  tabbarNornalImage:[settingDic objectForKey:@"nornal_img"] tabbarSeletedImage:[settingDic objectForKey:@"selected_img"]];
            [viewController addObject:navigationController];
        }else {
            [viewController removeLastObject];
        }
        self.viewControllers = viewController;
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
