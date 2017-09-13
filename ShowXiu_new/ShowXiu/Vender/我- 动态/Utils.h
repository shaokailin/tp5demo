
//  Utils.h
//  HopeYunmendian
//
//  Created by wangning on 15/12/23.
//  Copyright © 2015年 wangning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#define kLoginPlist @"login.plist"

@interface Utils : NSObject

@property (nonatomic,strong)UIView *view;

//获取Utils唯一对象
+ (Utils *)shareInstance;
+ (CGSize)setWidthForText:(NSString*)text fontSize:(CGFloat)fontSize labelSize:(CGFloat)labelSize isGetHight:(BOOL)isHight;

+ (CGSize)textSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font text:(NSString *)text;
@end
