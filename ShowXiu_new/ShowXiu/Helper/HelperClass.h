//
//  HelperClass.h
//  MusicPlayer
//
//  Created by hxcj on 16/12/22.
//  Copyright © 2016年 hxcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HelperClass : NSObject

#pragma mark - 手机号码验证
/**
 验证手机号码
 移动  134［0-8］ 135 136 137 138 139 150 151 152 158 159 182 183 184 157 187 188 147 178
 联通  130 131 132 155 156 145 185 186 176
 电信  133 153 180 181 189 177

 上网卡专属号段
 移动 147
 联通 145

 虚拟运营商专属号段
 移动 1705
 联通 1709
 电信 170 1700

 卫星通信 1349
*/
+ (BOOL)isPhoneNumberWith:(NSString *)phoneStr;

#pragma mark - 根据颜色尺寸生成一张图片
/**
 *  根绝颜色尺寸生成一张图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - 时间 -> 时间戳
/**
 *  时间 -> 时间戳
 *
 *  @param timeStr 时间字符串
 *  @param format  时间的格式
 *
 */
+ (NSString *)timeIsConvertedToTimeStamp:(NSString *)timeStr formatter:(NSString *)format;

#pragma mark - 时间戳 -> 时间
/**
 *  时间戳 -> 时间
 *
 *  @param timeStampStr 时间戳字符串
 *  @param format       输出的时间格式
 *
 */
+ (NSString *)timeStampIsConvertedToTime:(NSString *)timeStampStr formatter:(NSString *)format;

#pragma mark - 根据图片url获取图片尺寸
/**
 *  根据图片的url获取图片的尺寸
 *
 *  @param imageURL 图片地址
 *
 */
+ (CGSize)getImageSizeWithURL:(id)imageURL;

#pragma mark - 获取 IP 地址
/**
 *  获取ip地址
 *
 *  @return 本机的ip地址
 *
 */
+ (NSString *)getIPAddress;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

+ (CGFloat)calculationHeightWithTextsize:(CGFloat)text_h LabelWidth:(CGFloat)label_w WithText:(NSString *)str LineSpacing:(CGFloat)lineSpacing;




@end
