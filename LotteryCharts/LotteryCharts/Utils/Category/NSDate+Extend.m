//
//  NSDate+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSDate+Extend.h"
static NSString *const kTIMEDEFAULTFORMATTER = @"yyyy-MM-dd";//时间转换默认的格式
static NSDateFormatter * _formatter = nil;
static NSCalendar * _calendar = nil;
static NSDateComponents *_comps = nil;
@implementation NSDate (Extend)
+ (NSInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month {
    if((month == 0)||(month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if((year % 4 == 1)||(year % 4 == 2)||(year % 4 == 3))
    {
        return 28;
    }
    if(year % 400 == 0)
        return 29;
    if(year % 100 == 0)
        return 28;
    return 29;
}
//获取今天的日期
+ (NSDate *)getTodayDate {
    return [NSDate stringTransToDate:[[NSDate date] dateTransformToString:nil] withFormat:nil];
}
//获取明天的日期
+ (NSDate *)getTomorrowDate {
    return [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:[NSDate getTodayDate]];
}
//判断是否是今天的
+(BOOL)isTimestampToToday:(NSTimeInterval)timeInterval
{
    if (timeInterval > 0) {
        NSDate *saveDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSString *saveString = [saveDate dateTransformToString:kTIMEDEFAULTFORMATTER];
        NSString *currentString = [[NSDate date]dateTransformToString:kTIMEDEFAULTFORMATTER];
        if (![saveString isEqualToString:currentString]) {
            return NO;
        }else
        {
            return YES;
        }
    }else
    {
        return NO;
    }
}

//字符串转日期
+ (NSDate *)stringTransToDate:(NSString *)timeString withFormat:(NSString *)format
{
    if (KJudgeIsNullData(timeString)) {
        NSDate *currentDate = [NSDate date];
        NSDateFormatter * formatter = [currentDate setupFormatter];
        [formatter setDateFormat:[currentDate dateFormatString:format]];
        NSDate *date = [formatter dateFromString:timeString];
        return date;
    }
    return nil;
}
//日期转字符串
-(NSString *)dateTransformToString:(NSString *)format
{
    NSString *timeString = nil;
    if (self != nil) {
        [self setupFormatter];
        [_formatter setDateFormat:[self dateFormatString:format]];
        timeString = [_formatter stringFromDate:self];
    }
    return KNullTransformNumber(timeString);
}

- (NSString *)dateFormatString:(NSString *)format {
    return KJudgeIsNullData(format) ? format:kTIMEDEFAULTFORMATTER;
}

-(NSDateFormatter *)setupFormatter {
    if (_formatter == nil || [_formatter isKindOfClass:[NSNull class]]) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return _formatter;
}
-(NSCalendar *)setupCalendar {
    if (_calendar == nil || [_calendar isKindOfClass:[NSNull class]]) {
        _calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return _calendar;
}
-(NSDateComponents *)setupDateComponents {
    if (_comps == nil || [_comps isKindOfClass:[NSNull class]]) {
        _comps =  [[NSDateComponents alloc]init];
    }
    return _comps;
}
- (NSString *)getWeekDate {
    [self setupDateComponents];
    [self setupCalendar];
    if (self) {
        _comps = [_calendar components:NSCalendarUnitWeekday fromDate:self];
        return [[self class] weekForIndex:_comps.weekday];
    }
    return nil;
}
- (NSInteger )getWeekIndex {
    [self setupDateComponents];
    [self setupCalendar];
    if (self) {
        _comps = [_calendar components:NSCalendarUnitWeekday fromDate:self];
        return [[self class] weekIndexForIndex:_comps.weekday];
    }
    return 0;
}
+ (NSInteger)weekIndexForIndex:(NSInteger)index {
    NSInteger week = 0;
    switch (index) {
        case 1:
            week = 7;
            break;
        case 2:
            week = 1;
            break;
        case 3:
            week = 2;
            break;
        case 4:
            week = 3;
            break;
        case 5:
            week = 4;
            break;
        case 6:
            week = 5;
            break;
        case 7:
            week = 6;
            break;
        default:
            break;
    }
    return week;
}
+ (NSString *)weekForIndex:(NSInteger)index {
    NSString *week = nil;
    switch (index) {
        case 1:
            week = @"星期天";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
        default:
            break;
    }
    return week;
}
@end
