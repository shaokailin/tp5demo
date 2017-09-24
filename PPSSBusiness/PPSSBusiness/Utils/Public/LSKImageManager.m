//
//  LSKImageManager.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKImageManager.h"
#import <AVFoundation/AVFoundation.h>
@implementation LSKImageManager
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

+ (UIImage *)initializeQRCodeImage:(NSString *)qrcString size:(CGSize)size {
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSData *data = [qrcString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 3. 生成二维码
    CIImage *outputImage = [filter outputImage];
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size.width];
}
/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


+ (BOOL)isAvailableSelectAVCapture:(NSString *)type
{
    __block BOOL isAvalible = NO;
    BOOL showAlertView = YES;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:type];
    if (status == AVAuthorizationStatusRestricted) {
        //不允许用户访问媒体捕捉设备。
        //            DEBUG_Log(@"Restricted");
    }else if (status == AVAuthorizationStatusDenied)
    {
        //用户明确否认媒体捕捉的许可。
        //            DEBUG_Log(@"Denied");
    }else if (status == AVAuthorizationStatusAuthorized)
    {
        //用户明确同意媒体捕捉，或显式的用户权限是没有必要的问题中的媒体类型。
        //            DEBUG_Log(@"Authorized");
        isAvalible = YES;
    }else if (status == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
            if (granted) {
                isAvalible = YES;
            }else
            {
                isAvalible = NO;
            }
        }];
        showAlertView = NO;
    } else {
    }
    if ( isAvalible==NO && showAlertView ) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"应用尚未获取访问相机的权限,如需使用请到系统设置->隐私->相机中开启"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alter show];
    }
    return isAvalible;
}
@end
