//
//  PPSSPublickViewManager.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSPublicViewManager : NSObject

/**
 初始化主题颜色btn

 @param title 字
 @param target 目标
 @param action 方法
 @return btn
 */
+ (UIButton *)initAPPThemeBtn:(NSString *)title
                         font:(CGFloat)font
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)initBtnWithNornalImage:(NSString *)nornalImage
                       target:(id)target
                       action:(SEL)action;

/**
 初始化线视图

 @return Line
 */
+ (UIView *)initializeLineView;

/**
 初始化Lbl  颜色 是 333333 12px

 @param text 内容
 @return Lbl
 */
+ (UILabel *)initLblForColor3333:(NSString *)text textAlignment:(NSTextAlignment)alignment;

/**
 初始化灰色Lbl 颜色 666666 10px

 @param text 内容
 @return Lbl
 */
+ (UILabel *)initLblForColor6666:(NSString *)text;
/**
 初始化灰色Lbl 颜色 99999 10px
 
 @param text 内容
 @return Lbl
 */
+ (UILabel *)initLblForColor9999:(NSString *)text;

/**
 初始化粉红Lbl 颜色 fe4070 10px
 
 @param text 内容
 @return Lbl
 */
+ (UILabel *)initLblForColorPink:(NSString *)text textAlignment:(NSTextAlignment)alignment ;
@end
