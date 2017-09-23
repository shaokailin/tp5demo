//
//  UIBarButtonItem+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)
/**
 因为iOS7以后整个的导航栏按钮会离边多了10px。
 @return 空类型的 UIBarButtonItem
 */
+ (UIBarButtonItem *)initBarButtonItemSpace;
/**
 初始化导航栏控件
 
 @param nornalImage 显示的图片
 @param seletedImage 选中状态下的图片
 @param title 标题
 @param target 事件处理者
 @param font 字体大小
 @param color 字体颜色
 @param action 触发的事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)initBarButtonItemWithNornalImage:(NSString *)nornalImage
                                         seletedImage:(NSString *)seletedImage
                                                title:(NSString *)title
                                                 font:(CGFloat)font
                                            fontColor:(UIColor *)color
                                               target:(id)target
                                               action:(SEL)action;
@end
