//
//  UITabBarController+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "UITabBarController+Extend.h"
#import "LSKImageManager.h"
@implementation UITabBarController (Extend)

- (void)setupTabbarNornalTitleColor:(UIColor *)nornalColor
            tabbarSelectdTitleColor:(UIColor *)selectedColor
                    tabbarTitleFont:(CGFloat) font {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:nornalColor, NSForegroundColorAttributeName,FontNornalInit(font),NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:selectedColor, NSForegroundColorAttributeName,FontNornalInit(font),NSFontAttributeName,nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -5)];
}
- (UINavigationController *)initializeNavigationWithClass :(NSString *)className
                                                naviTitle :(NSString *)naviTitle
                                              tabbarTitle :(NSString *)tabbarTitle
                                        tabbarNornalImage :(NSString *)nornalImage
                                       tabbarSeletedImage :(NSString *)seletedImage {
    UIViewController *viewController = [[NSClassFromString(className) alloc]init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    viewController.title = naviTitle;
    [self setupTabBarItemWithTabBarItem:navigation.tabBarItem title:tabbarTitle nornalImage:KJudgeIsNullData(nornalImage) ? ImageNameInit(nornalImage) : nil seletedImage:KJudgeIsNullData(seletedImage) ? ImageNameInit(seletedImage) : nil];
    return navigation;
}
#pragma mark UITabBar change
- (void)setupTabBarBackgroundColor:(UIColor *)bgColor {
    self.tabBar.translucent = NO;
    [self.tabBar setBackgroundImage:[LSKImageManager imageWithColor:bgColor size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
    [self.tabBar setShadowImage:[LSKImageManager imageWithColor:ColorHexadecimal(kMainBackground_Color, 1.0) size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
}
//设置导航栏对应的tabbar的内容、icon
- (void)setupTabBarItemWithTabBarItem :(UITabBarItem *)item
                                title :(NSString *)title
                          nornalImage :(UIImage *)nornalImage
                         seletedImage :(UIImage *)seletedImage {
    [item setTitle:title];
    if (nornalImage) {
        [item setImage:[nornalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    if (seletedImage) {
        [item setSelectedImage:[seletedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    if (nornalImage || seletedImage) {
        [item setImageInsets:UIEdgeInsetsMake(0, 0.0, 0, 0.0)];
    }
}
@end
