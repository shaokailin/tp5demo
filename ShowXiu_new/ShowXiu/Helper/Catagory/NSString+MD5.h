//
//  NSString+MD5.h
//  MusicPlayer
//
//  Created by hxcj on 16/12/30.
//  Copyright © 2016年 hxcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  md5加密类方法
 *
 *  @param inputStr 要加密的字符串
 *
 *  @return md5加密结果字符串
 */
+ (NSString *)md5EncryptionWithInputStr:(NSString *)inputStr;

/**
 *  md5加密对象方法
 *
 *  @return md5加密结果
 */
- (NSString *)md5Encryption;

/**
 *  md5加密类方法 (其他算法)
 *
 *  @param inputStr 要加密的字符串
 *
 *  @return 加密结果
 */
+ (NSString *)md5EncryptionOtherAlgorithmWith:(NSString *)inputStr;



@end
