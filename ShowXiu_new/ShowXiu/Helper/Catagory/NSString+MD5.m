//
//  NSString+MD5.m
//  MusicPlayer
//
//  Created by hxcj on 16/12/30.
//  Copyright © 2016年 hxcj. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)

#pragma mark - md5加密类方法
+ (NSString *)md5EncryptionWithInputStr:(NSString *)inputStr {
    const char *myPasswd = [inputStr UTF8String];
    unsigned char mdc[16];
    CC_MD5 (myPasswd, (CC_LONG) strlen(myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < 16 ; i++) {
        [md5String appendFormat : @"%02x" ,mdc[i]];
    }
    return md5String;
}

#pragma mark - md5加密对象方法
- (NSString *)md5Encryption {
    const char *data = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/** md5加密, 其他算法 */
+ (NSString *)md5EncryptionOtherAlgorithmWith:(NSString *)inputStr {
    const char *myPasswd = [inputStr UTF8String];
    unsigned char mdc[16];
    CC_MD5 (myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    [md5String appendFormat : @"%02x" ,mdc[0]];
    for ( int i = 1 ; i < 16 ; i++) {
        [md5String appendFormat : @"%02x", mdc[i]^mdc[0]];
    }
    return md5String;
}



@end
