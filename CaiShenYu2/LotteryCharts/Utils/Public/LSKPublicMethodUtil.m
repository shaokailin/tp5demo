//
//  LSKPublicMethodUtil.m
//  SingleStore
//
//  Created by LSKlan on 2017/9/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKPublicMethodUtil.h"
#import <SDWebImage/SDImageCache.h>
@implementation LSKPublicMethodUtil
//获取版本号
+ (CGFloat)getiOSSystemVersion {
    return [[[UIDevice currentDevice]systemVersion]floatValue];
}

+ (LSKiOSSystemLevel)getiOSSystemLevel {
    CGFloat version = [LSKPublicMethodUtil getiOSSystemVersion];
    LSKiOSSystemLevel level = 0;
    if (version < 8.0) level = LSKiOSSystemLevel_iOS7;
    else if (version >= 8.0 && version < 9) level = LSKiOSSystemLevel_iOS8;
    else if (version >= 9.0 && version < 10.0) level = LSKiOSSystemLevel_iOS9;
    else if (version >= 10.0 && version < 11.0) level = LSKiOSSystemLevel_iOS10;
    else if (version >= 11.0 && version < 12.0) level = LSKiOSSystemLevel_iOS11;
    else level = LSKiOSSystemLevel_iOSMore;
    return level;
}

+ (LSKiOSiPhoneType)getiPhoneType {
    LSKiOSiPhoneType iPhoneType = LSKiOSiPhoneType_iPhone6;
    CGSize screenSize = [[UIScreen mainScreen]currentMode].size;
    if (CGSizeEqualToSize(CGSizeMake(640, 960), screenSize)) iPhoneType = LSKiOSiPhoneType_iPhone4;
    else if (CGSizeEqualToSize(CGSizeMake(640, 1136), screenSize)) iPhoneType = LSKiOSiPhoneType_iPhone5;
    else if (CGSizeEqualToSize(CGSizeMake(750, 1334), screenSize)) iPhoneType = LSKiOSiPhoneType_iPhone6;
    else if ([[UIScreen mainScreen] scale] >=3) iPhoneType = LSKiOSiPhoneType_iPhone6P;
    
    return iPhoneType;
}

+ (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - json 和 字典 的转换
// 将字典转字符串
+ (NSString *)dictionaryTransformToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError != nil) return @"";
    else return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSString *)arrayTransformToJson:(NSArray *)array {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError != nil) return @"";
    else return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//NSData 转 字典
+ (id)jsonDataTransformToDictionary :(NSData *)data {
    NSDictionary *responseDistionary = nil;
    //java 服务器出现奔溃的时候会返回 _NSZeroData 的<> 格式的错误
    if (data != nil && ![data isKindOfClass:[NSClassFromString(@"_NSZeroData") class]]) {
        NSError *error = nil;
        responseDistionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            LSKLog(@"请求数据问题====%@",error);
            return nil;
        }
    }
    return responseDistionary;
}

#pragma mark - 缓存
// 1.计算单个文件大小
+ (CGFloat)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size / 1024.0 / 1024.0;
    }
    return 0;
}

// 2.计算文件夹大小(要利用上面的1提供的方法)
+ (CGFloat)memoryCacheSize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [LSKPublicMethodUtil fileSizeAtPath:absolutePath];
        }
        // SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
        return folderSize;
    }
    return 0;
}

// 3.清除缓存
+ (void)clearMemoryCache {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearMemory];
}

+ (void)callPhone:(NSString *)phone {
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phone]];
    if ([[UIApplication sharedApplication]canOpenURL:telUrl]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication]openURL:telUrl];
        });
    }
}

+ (UIColor *)utilsColorManager:(NSString *)colorString {
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return nil;
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 空值判断
+ (id)nullTransformMoney:(id)value {
    if (![[self class] isHasValue:value]) {
        return @"0.00";
    }
    return value;
}

+ (id)nullTransformNumber:(id)value {
    if (![[self class] isHasValue:value]) {
        return @"0";
    }
    return value;
}
+ (id)nullTransformString:(id)value {
    if (![[self class] isHasValue:value]) {
        return @"";
    }
    return value;
}

+ (BOOL)isHasValue:(id)value {
    if (!value || [value isKindOfClass:[NSNull class]] || (([NSStringFromClass([value class])isEqualToString:@"__NSCFConstantString"] || [NSStringFromClass([value class])isEqualToString:@"__NSCFString"]) &&  (((NSString *)value).length == 0 || [(NSString *)value isEqualToString:@""]))) {
        return NO;
    }
    return YES;
}
+ (BOOL)isArrayAndValue:(id)value {
    if (value && [value isKindOfClass:[NSArray class]] && ((NSArray *)value).count > 0) {
        return YES;
    }
    return NO;
}
+ (NSString *)timeStr:(long long)timestamp
{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    
    // 进行判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        //今天
        dateFmt.dateFormat = @"HH:mm";
    }else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay ){
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }else if(currentYear == msgYear){
        //昨天以前
        dateFmt.dateFormat = @"MM-dd HH:mm";
    }else {
        dateFmt.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    // 返回处理后的结果
    return [dateFmt stringFromDate:msgDate];
}
@end
