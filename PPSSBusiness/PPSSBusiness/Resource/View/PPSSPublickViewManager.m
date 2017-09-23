//
//  PPSSPublickViewManager.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPublicViewManager.h"

@implementation PPSSPublicViewManager
+ (UIView *)initializeLineView {
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    return lineView;
}
+ (UILabel *)initLblForColor3333:(NSString *)text textAlignment:(NSTextAlignment)alignment {
    UILabel *lable = [LSKViewFactory initializeLableWithText:text font:12 textColor:ColorHexadecimal(Color_Text_3333, 1.0) textAlignment:alignment backgroundColor:nil];
    return lable;
}
+ (UILabel *)initLblForColor6666:(NSString *)text {
    UILabel *lable = [LSKViewFactory initializeLableWithText:text font:10 textColor:ColorHexadecimal(Color_Text_6666, 1.0) textAlignment:0 backgroundColor:nil];
    return lable;
}
+ (UILabel *)initLblForColor9999:(NSString *)text {
    UILabel *lable = [LSKViewFactory initializeLableWithText:text font:10 textColor:ColorHexadecimal(Color_Text_9999, 1.0) textAlignment:0 backgroundColor:nil];
    return lable;
}
+ (UILabel *)initLblForColorPink:(NSString *)text textAlignment:(NSTextAlignment)alignment {
    UILabel *lable = [LSKViewFactory initializeLableWithText:text font:10 textColor:ColorHexadecimal(Color_Text_Pink, 1.0) textAlignment:alignment backgroundColor:nil];
    return lable;
}
+ (UIButton *)initAPPThemeBtn:(NSString *)title font:(CGFloat)font target:(id)target action:(SEL)action {
    return [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:target action:action textfont:font textColor:COLOR_WHITECOLOR backgroundColor:ColorHexadecimal(Color_APP_MAIN, 1.0) backgroundImage:nil];
}
+ (UIButton *)initBtnWithNornalImage:(NSString *)nornalImage target:(id)target action:(SEL)action {
    return [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nornalImage selectedImage:nil target:target action:action textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
}
@end
