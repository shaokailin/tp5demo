//
//  LSKViewFactory.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPKeyboardAvoidingTableView,TPKeyboardAvoidingScrollView;
@interface LSKViewFactory : NSObject

/**
 UILabel

 @param text 内容
 @param font 字体大小
 @param textColor 字体颜色
 @param alignment 对其方式
 @param bgColor 背景颜色
 @return UILabel
 */
+ (UILabel *)initializeLableWithText :(NSString *)text
                                font :(CGFloat)font
                           textColor :(UIColor *)textColor
                       textAlignment :(NSTextAlignment)alignment
                     backgroundColor :(UIColor *)bgColor;

/**
 UIButton

 @param title 内容
 @param nornalImage 正常图片
 @param selectedImage 选中图片
 @param target 代理
 @param action 触发事件
 @param font 字体大小
 @param textColor 文本颜色
 @param bgColor 背景颜色
 @param bgImage 背景图片
 @return UIButton
 */
+ (UIButton *)initializeButtonWithTitle :(NSString *)title
                            nornalImage :(NSString *)nornalImage
                          selectedImage :(NSString *)selectedImage
                                 target :(id)target
                                 action :(SEL)action
                               textfont :(CGFloat)font
                              textColor :(UIColor *)textColor
                        backgroundColor :(UIColor *)bgColor
                        backgroundImage :(NSString *)bgImage;

/**
 UITextField

 @param delegate 代理
 @param text 内容
 @param placeholder 默认内容
 @param font 字体大小
 @param color 字体颜色
 @param placeholderColor 默认颜色
 @param alignment 对其方式
 @param style 样式
 @param returnType 返回样式
 @param keyBoard 键盘样式
 @param cleanMode 是否显示清空
 @return UITextField
 */
+ (UITextField *)initializeTextFieldWithDelegate:(id)delegate
                                            text:(NSString *)text
                                     placeholder:(NSString *)placeholder
                                        textFont:(CGFloat)font
                                       textColor:(UIColor *)color
                                placeholderColor:(UIColor *)placeholderColor
                                   textAlignment:(NSTextAlignment)alignment borStyle:(UITextBorderStyle)style
                                       returnKey:(UIReturnKeyType)returnType
                                        keyBoard:(UIKeyboardType)keyBoard
                                      cleanModel:(UITextFieldViewMode)cleanMode;

/**
 UITableView

 @param delegate 代理
 @param style 样式
 @param separatorStyle 分割线样式
 @param headAction 刷新
 @param footAction 加载更多
 @param separatorColor 线
 @param backgroundColor 背景颜色
 @return UITableView
 */
+(UITableView *)initializeTableViewWithDelegate :(id)delegate
                                      tableType :(UITableViewStyle)style
                                 separatorStyle :(UITableViewCellSeparatorStyle) separatorStyle
                              headRefreshAction :(SEL)headAction
                              footRefreshAction :(SEL)footAction
                                 separatorColor :(UIColor *)separatorColor
                                backgroundColor :(UIColor *)backgroundColor;
+ (TPKeyboardAvoidingTableView *)initializeTPTableViewWithDelegate:(id)delegate tableType:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction separatorColor:(UIColor *)separatorColor backgroundColor:(UIColor *)backgroundColor;
+ (TPKeyboardAvoidingScrollView *)initializeTPScrollView;
/**
 UICollectionView

 @param delegate 代理
 @param layout UICollectionViewLayout 一些属性
 @param headAction 刷新事件
 @param footAction 加载更多事件
 @param backgroundColor 背景颜色
 @return UICollectionView
 */
+ (UICollectionView *)initializeCollectionViewWithDelegate:(id)delegate  collectionViewLayout:(UICollectionViewLayout *)layout headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction backgroundColor:(UIColor *)backgroundColor ;

/**
 设置tableview 的加载
 
 @param scrollView 需要设置的scrollView
 @param page 页码
 @param count 当前总个数
 */
+ (void)setupFootRefresh:(UIScrollView *)scrollView page:(NSInteger)page currentCount:(NSInteger)count;
/**
 设置导航栏
 
 @param bgColor 背景颜色
 @param font 字体大小
 @param titleColor 字体颜色
 @param lineColor 线颜色
 */
+ (void)setupMainNavigationBgColor:(UIColor *)bgColor titleFont:(CGFloat)font titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor;

/**
 获取当前的控制器

 @return UIViewController
 */
+ (UIViewController *)getCurrentViewController;
@end
