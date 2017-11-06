//
//  NSString+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extend)

//版本比较3.6.2  与 3.6.7
+ (BOOL)compareVersionWithCurrent:(NSString *)version newVersion:(NSString *)newVersion {
    if (!KJudgeIsNullData(version) && KJudgeIsNullData(newVersion)) {
        return YES;
    }
    if (!KJudgeIsNullData(version) || !KJudgeIsNullData(newVersion)) {
        return NO;
    }
    if ([newVersion compare:version options:NSNumericSearch] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

//去空格
- (NSString *)stringBySpaceTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 字符串内容大小
- (CGSize)calculateTextSize:(CGFloat)font size:(CGSize)size {
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FontNornalInit(font)} context:nil];
    return rect.size;
}
- (CGFloat)calculateTextWidth:(CGFloat)font {
    return [self calculateTextSize:font size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
}

- (CGFloat)calculateTextHeight:(CGFloat)font width:(CGFloat)width {
    return [self calculateTextSize:font size:CGSizeMake(width, MAXFLOAT)].height;
}

#pragma mark -MD5
+ (NSString *)MD5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark 正则表达式
//是否是数字
- (BOOL)validateNumber {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\\d.])$"]evaluateWithObject:self];
}
//是否是数字或者英文组合的
- (BOOL)validateNumberOrLetter {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([0-9A-Za-z_])$"] evaluateWithObject:self];
}
//是否是数字6位验证码
- (BOOL)validateCode {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"\\d{6}"] evaluateWithObject:self];
}

//是否是电话号码
- (BOOL)validateMobilePhone {
    NSRange range = [self rangeOfString:@"-"];
    NSString *mobileString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];;
    if (range.location != NSNotFound) {
        mobileString = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    NSString *phoneRegex = @"^1[3456789][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [predicate evaluateWithObject:mobileString];
}
//是否是身份证
- (BOOL)validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
@end
