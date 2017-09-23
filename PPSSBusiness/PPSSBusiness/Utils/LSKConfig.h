//
//  LSKConfig.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#ifndef LSKConfig_h
#define LSKConfig_h
//分页大小
static const NSInteger PAGE_SIZE_NUMBER = 15;
//支持 @“0x888888,1.0” 前面颜色，后面透明度
//LSKActionSheet的字体颜色
static NSString * const kActionSheetText_Color = @"0x333333";
//LSKActionSheet的线颜色
static NSString * const kActionSheetLine_Color = @"0xc6c6c6";
//WebViewProgress color
static NSString * const kWebViewProgressStart_Color = @"0x46bdf9";
static NSString * const kWebViewProgressEnd_Color = @"0x0c72e3";
//navigation 颜色
static NSString * const kNavigationBarButtonTitle_Color = @"0xffffff";
static NSString * const kNavigationBackground_Color = @"0x3c9efa";
static NSString * const kNavigationTitle_Color = kNavigationBarButtonTitle_Color;
static NSString * const kNavigationLine_Color = nil;
static const NSInteger kNavigationTitle_Font = 16;
//tabbar 颜色
static NSString * const kTabBarBackground_Color = kNavigationBarButtonTitle_Color;
static NSString * const kTabBarTitleNornal_Color = @"0x888888";
static NSString * const kTabBarTitleSelected_Color = @"0xf12e57";
static const NSInteger kTabBarTitle_Font = 11;
//主要的背景色
static const NSInteger kMainBackground_Color  = 0xf1f1f1;
//网络请求地址
#ifdef DEBUG
static NSString * const SERVER_URL = @"http://192.168.0.98:8080/";
static NSString * const HTTPS_CA_NAME = @"";
static NSString * const HTTPS_CA_TYPE = @"";
#else
static NSString * const SERVER_URL = @"http://192.168.0.98:8080/";
static NSString * const HTTPS_CA_NAME = @"";
static NSString * const HTTPS_CA_TYPE = @"";
#endif


//请求类型
typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    HTTPRequestType_GET = 0,
    HTTPRequestType_POST,
    HTTPRequestType_MultiPartPOST
};
//上传媒体的类型  除了图片，其他要额外进行适配
typedef  NS_ENUM(NSInteger,LSKUploadMediaType){
    LSKUploadMediaType_PNG = 0,
    LSKUploadMediaType_JPEG
};

/**
 请求成功回调
 
 @param identifier 标识
 @param model 请求回调后参数model化
 */
typedef void (^HttpSuccessBlock)(NSUInteger identifier, id model);
/**
 请求失败回调
 
 @param identifier 标识
 @param error 请求错误
 */
typedef void (^HttpFailureBlock)(NSUInteger identifier, NSError *error);

//测试
#ifdef DEBUG
#   define LSKLog(fmt, ...) {NSLog((@"^ %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#   define LSKLog(...)
#endif

//block 弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//可以对于多方法调用的时候 使用
//#define kWeakSelf(type)__weak typeof(type)weak##type = type;
//#define kStrongSelf(type)__strong typeof(type)type = weak##type;

/// Height/Width
//屏幕宽度
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
//主视图的高度
#define VIEW_MAIN_HEIGHT         ([UIScreen mainScreen].bounds.size.height - 64.0)
//根据设计图来分辨比例
#define WIDTH_RACE_5S(x)        ((x) * SCREEN_WIDTH) / 320.0
//基于iPhone 6 开发的比例
#define WIDTH_RACE_6S(x)           ((x) * SCREEN_WIDTH) / 375.0

//字符串拼接
#define NSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

//字体大小的初始化
#define FontNornalInit(font)  [UIFont systemFontOfSize:(font)]
#define FontBoldInit(x) [UIFont boldSystemFontOfSize:(x)]
//图片加载 name 是jpg要加example.jpg;file 需要全名（@2x）设置
#define ImageNameInit(img)  [UIImage imageNamed:(img)]
#define ImageFileInit(img,type)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(img) ofType:(type)]]

//颜色设置
#define ColorRGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//16进制设置
#define ColorHexadecimal(rgbValue,a) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:a]
//颜色字符串 只支持 16位
#define ColorUtilsString(colorString) [LSKPublicMethodUtil utilsColorManager:(colorString)]

#endif /* LSKConfig_h */
