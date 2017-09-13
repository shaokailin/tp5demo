//
//  UIImage+Extension.h
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 圆角图片
- (UIImage *)clipImageWithRadius:(CGFloat)radius;

- (UIImage *)createImageWithColor:(UIColor *)color;

// 图片拉伸
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

+ (UIImage *)fastImageWithData:(NSData *)data;
+ (UIImage *)fastImageWithContentsOfFile:(NSString *)path;
+ (UIImage *)imageCompressForWidths:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
