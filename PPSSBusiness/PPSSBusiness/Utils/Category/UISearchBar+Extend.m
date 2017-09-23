//
//  UISearchBar+Extend.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "UISearchBar+Extend.h"
#import "LSKImageManager.h"
@implementation UISearchBar (Extend)
-(void)settingSearchBarBackgroundColor:(UIColor *)backgroundColor textFieldBackgroundColor:(UIColor *)textFieldBackgroundColor returnKeyType:(UIReturnKeyType)type textColor:(UIColor *)textColor  placeholderColor:(UIColor *)placeholderColor btnTitle:(NSString *)btnTitle btnColor:(UIColor *)btnColor
{
    //修改搜索条的背景色
    [self setImage:[UIImage imageNamed:@"search_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    if (backgroundColor) {
        [self setBackgroundImage:[LSKImageManager imageWithColor:backgroundColor size:CGSizeMake(SCREEN_WIDTH, 44)]];
    }
    NSInteger hasType = 0;
    for (UIView *subview in self.subviews) {
        for (UIView *subSubView in subview.subviews) {
         if ([subSubView isKindOfClass:NSClassFromString(@"UISearchBarTextField")])
            {
                UITextField *tTextField=(UITextField *)subSubView;
                [tTextField setBackgroundColor:textFieldBackgroundColor];
                tTextField.font = FontNornalInit(12);
                tTextField.returnKeyType = type;
//                [tTextField setBorderStyle:UITextBorderStyleRoundedRect];
//                UIImageView *search = [[UIImageView alloc]initWithFrame:tTextField.leftView.frame];
//                search.image = ImageNameInit(@"search_icon");
//                tTextField.leftView = search;
                tTextField.textColor= textColor;
                if (placeholderColor) {
                     [tTextField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
                }
               tTextField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                hasType += 1;
            }
            else if([subSubView isKindOfClass:[UIButton class]] && ([btnTitle isHasValue] || btnColor))
            {
                UIButton *button = (UIButton *)subSubView;
                if ([btnTitle isHasValue]) {
                    [button setTitle:btnTitle
                            forState:UIControlStateNormal];
                }
                if (btnColor) {
                    [button setTitleColor:btnColor forState:UIControlStateNormal];
                }
                [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
                hasType += 1;
            }
            if (hasType == 2) {
                break;
            }
        }
        if (hasType == 2) {
            break;
        }
    }
}
@end
