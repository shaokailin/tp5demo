//
//  UIBarButtonItem+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "NSString+Extend.h"
static const CGFloat kBARBUTTONITEMHEIGHT = 25.0;//按钮的宽高
static const CGFloat kBARBUTTONITEMWIDTH = 30;//按钮的宽高
static const CGFloat kBARBUTTONITEMSPACEWIDTH = -15.0;//空白 UIBarButtonItem 的大小

@implementation UIBarButtonItem (Extend)
//添加空白按钮
+ (UIBarButtonItem *)initBarButtonItemSpace
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = kBARBUTTONITEMSPACEWIDTH;
    return negativeSpacer;
}

//添加自定义按钮
+ (UIBarButtonItem *)initBarButtonItemWithNornalImage:(NSString *)nornalImage
                                         seletedImage:(NSString *)seletedImage
                                                title:(NSString *)title
                                                 font:(CGFloat)font
                                            fontColor:(UIColor *)color
                                               target:(id)target
                                               action:(SEL)action isRight:(BOOL)isRight
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[button titleLabel]setFont:FontNornalInit(font)];
    CGRect buttonFrame = [button frame];
    if (KJudgeIsNullData(title)) {
        buttonFrame.size.width = [title calculateTextWidth:font] + 10;
        buttonFrame.size.height = kBARBUTTONITEMHEIGHT;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateNormal];
    }else
    {
        buttonFrame.size = CGSizeMake(kBARBUTTONITEMWIDTH, kBARBUTTONITEMHEIGHT);
    }
    [button setFrame:buttonFrame];
    if (KJudgeIsNullData(nornalImage)) {
        [button setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
    if (KJudgeIsNullData(seletedImage)) {
        [button setImage:[UIImage imageNamed:seletedImage] forState:UIControlStateSelected];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([LSKPublicMethodUtil getiOSSystemVersion] >= 11.0) {
        if (isRight) {
            button.contentEdgeInsets =UIEdgeInsetsMake(0, 0,0, kBARBUTTONITEMSPACEWIDTH);
        }else {
            button.contentEdgeInsets =UIEdgeInsetsMake(0, kBARBUTTONITEMSPACEWIDTH,0, 0);
        }
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return buttonItem;
}
@end
