//
//  UISearchBar+Extend.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (Extend)
-(void)settingSearchBarBackgroundColor:(UIColor *)backgroundColor textFieldBackgroundColor:(UIColor *)textFieldBackgroundColor returnKeyType:(UIReturnKeyType)type textColor:(UIColor *)textColor  placeholderColor:(UIColor *)placeholderColor btnTitle:(NSString *)btnTitle btnColor:(UIColor *)btnColor;
@end
