//
//  LSKPublicMethodUtil.h
//  SingleStore
//
//  Created by LSKlan on 2017/9/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
//iOS系统等级
typedef NS_ENUM(NSInteger , LSKiOSSystemLevel) {
    LSKiOSSystemLevel_iOS7 = 0,
    LSKiOSSystemLevel_iOS8 = 1,
    LSKiOSSystemLevel_iOS9 = 2,
    LSKiOSSystemLevel_iOS10 = 3,
    LSKiOSSystemLevel_iOS11 = 4,
    LSKiOSSystemLevel_iOSMore = 5
};
//iOS手机机型
typedef NS_ENUM(NSInteger , LSKiOSiPhoneType) {
    LSKiOSiPhoneType_iPhone4 = 0,
    LSKiOSiPhoneType_iPhone5 = 1,
    LSKiOSiPhoneType_iPhone6 = 2,
    LSKiOSiPhoneType_iPhone6P = 3,
    LSKiOSiPhoneType_iPhone8 = 4,
    LSKiOSiPhoneType_iPhone8P = 5,
};
@interface LSKPublicMethodUtil : NSObject
/**
 获取当前的版本号
 
 @return 版本号 比如10.3、9.2
 */
+ (CGFloat)getiOSSystemVersion;
/**
 获取版本等级
 
 @return iOS7、iOS8等
 */
+ (LSKiOSSystemLevel)getiOSSystemLevel;
/**
 获取手机机型
 
 @return 机型
 */
+ (LSKiOSiPhoneType)getiPhoneType;
/**
 获取APP的版本号
 
 @return 1.0.0这样的格式
 */
+ (NSString *)getAppVersion;

/**
 字典转json字符串
 
 @param dic 字典
 @return 字符串
 */
+ (NSString *)dictionaryTransformToJson:(NSDictionary *)dic;
+ (NSString *)arrayTransformToJson:(NSArray *)array;
/**
 data 转 dictionary

 @param data NSData
 @return 对象 NSDictionary 或者 NSArray 或者 nil

 */
+ (id)jsonDataTransformToDictionary :(NSData *)data;

/**
 获取缓存大小

 @return M为单位的大小
 */
+ (CGFloat)memoryCacheSize;

/**
 清除缓存
 */
+ (void)clearMemoryCache;


/**
 拨打电话
 需要在info.plist 添加 LSApplicationQueriesSchemes 里面添加telprompt

 @param phone 电话号码
 */
+ (void)callPhone:(NSString *)phone;

/**
 颜色设置

 @param colorString 定义的颜色值 0xffffff,0 或者 nil 或者 0xffffff 3种格式
 @return UIColor
 */
+ (UIColor *)utilsColorManager:(NSString *)colorString;

#pragma mark 空值计算
/**
 空转钱的样式
 
 @return NSString
 */
+ (id)nullTransformMoney:(id)value;
/**
 空转数字的样式
 
 @return NSString
 */
+ (id)nullTransformNumber:(id)value;
/**
 空转字符串的样式
 
 @return NSString
 */
+ (id)nullTransformString:(id)value;

/**
 判断是否有值
 
 @return yes：有值
 */
+ (BOOL)isHasValue:(id)value;

/**
 判断是否是数组而且有值

 @param value 值
 @return 参数
 */
+ (BOOL)isArrayAndValue:(id)value;
@end
