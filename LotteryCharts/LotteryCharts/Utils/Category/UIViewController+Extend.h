//
//  UIViewController+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (Extend)

/**
 设置不全屏 0点 在导航栏的左下角开始
 */
- (void)setupNotFullScreen;

/**
 添加导航左按钮

 @param tLeftButton UIBarButtonItem
 */
- (void)addNavigationLeftButton:(UIBarButtonItem *)tLeftButton;
- (void)addNavigationLeftButtons:(NSArray<UIBarButtonItem *> *)leftButtons;
/**
 添加导航右按钮
 
 @param tRightButton UIBarButtonItem
 */
- (void)addNavigationRightButton:(UIBarButtonItem *)tRightButton;
- (void)addNavigationRightButtons:(NSArray<UIBarButtonItem *> *)rightButtons;
@end
