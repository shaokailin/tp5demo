//
//  NSDate+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)
- (NSString *)getWeekDate;
- (NSInteger )getWeekIndex;
/**
 获取某年某月的天数
 
 @param year 年份
 @param month 月份
 @return 天数
 */
+ (NSInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month;

/**
 获取今天的日期

 @return 日期
 */
+ (NSDate *)getTodayDate;

/**
 获取明天日期

 @return 日期
 */
+ (NSDate *)getTomorrowDate;

/**
 判断是否是今天的

 @param timeInterval 时间戳
 @return yes 今天 no 不是
 */
+(BOOL)isTimestampToToday:(NSTimeInterval)timeInterval;

/**
 字符串转日期

 @param timeString 时间窜
 @param format 转换类型 nil -》yyyy-MM-dd
 @return 时间
 */
+ (NSDate *)stringTransToDate:(NSString *)timeString withFormat:(NSString *)format;

/**
 日期转字符串

 @param format 转换类型 nil -》yyyy-MM-dd
 @return 字符串
 */
-(NSString *)dateTransformToString:(NSString *)format;
@end
