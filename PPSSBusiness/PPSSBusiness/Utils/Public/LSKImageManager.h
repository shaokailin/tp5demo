//
//  LSKImageManager.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSKImageManager : NSObject
+ (BOOL)isAvailableSelectAVCapture:(NSString *)type;
/**
 生成颜色图片

 @param color 图片的颜色
 @param size 生成图片的大小
 @return 颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 生成二维码

 @param qrcString 需要生成的二维码字符串
 @param size 生成图片的大小
 @return 二维码
 */
+ (UIImage *)initializeQRCodeImage:(NSString *)qrcString size:(CGSize)size;
@end
