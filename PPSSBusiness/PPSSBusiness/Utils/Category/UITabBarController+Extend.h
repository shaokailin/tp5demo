//
//  UITabBarController+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Extend)
/**
 设置TabBar的字体颜色和大小

 @param nornalColor 正常颜色
 @param selectedColor 选中颜色
 @param font 字体大小
 */
- (void)setupTabbarNornalTitleColor:(UIColor *)nornalColor
            tabbarSelectdTitleColor:(UIColor *)selectedColor
                    tabbarTitleFont:(CGFloat) font;

/**
 初始化导航tabbar的导航界面

 @param className 初始化的类名
 @param naviTitle 导航标题
 @param tabbarTitle 单个tabbar的标题
 @param nornalImage 单个tabbar的正常icon
 @param seletedImage 单个tabbar的选中状态下的icon
 @return 导航控制器
 */
- (UINavigationController *)initializeNavigationWithClass :(NSString *)className
                                                naviTitle :(NSString *)naviTitle
                                              tabbarTitle :(NSString *)tabbarTitle
                                        tabbarNornalImage :(NSString *)nornalImage
                                       tabbarSeletedImage :(NSString *)seletedImage;

/**
 设置背景颜色

 @param bgColor 颜色
 */
- (void)setupTabBarBackgroundColor:(UIColor *)bgColor;
@end
