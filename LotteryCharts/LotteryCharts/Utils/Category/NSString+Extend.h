//
//  NSString+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/*
 *版本是否需要更新
 *version:现在版本
 *newVersion : 新的版本
 *return bool yes 新的高 需要升级  no 等级低
 */
+ (BOOL)compareVersionWithCurrent :(NSString *)version newVersion :(NSString *)newVersion;
//去空格
- (NSString *)stringBySpaceTrim;
//MD5
+ (NSString *)MD5:(NSString *)string;
/*
 *获取文本宽高
 *font:字体宽高
 *size : 内容的限制区域
 */
- (CGSize)calculateTextSize:(CGFloat)font size:(CGSize)size;
- (CGFloat)calculateTextWidth:(CGFloat)font;
- (CGFloat)calculateTextHeight:(CGFloat)font width:(CGFloat)width;

//是否是身份证
- (BOOL)validateIdentityCard;
//是否是电话号码
- (BOOL)validateMobilePhone;
//是否是数字6位验证码
- (BOOL)validateCode;
//是否是数字或者英文组合的
- (BOOL)validateNumberOrLetter;
//是否是数字
- (BOOL)validateNumber;
@end
