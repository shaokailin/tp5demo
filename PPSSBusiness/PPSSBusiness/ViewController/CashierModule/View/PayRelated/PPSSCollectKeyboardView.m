//
//  PPSSCollectKeyboardView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCollectKeyboardView.h"
@interface PPSSCollectKeyboardView()
{
    CGFloat _btnWidth;
    CGFloat _betweenWidth;
    UIButton *_collectBtn;
    NSInteger _currentOperation;
    UIColor *_nornalColor;
    UIColor *_selectColor;
}
//NSDecimalNumber*jianfa1 = [NSDecimalNumber decimalNumberWithString:@"55.55555"];
//NSDecimalNumber*jiafa= [jiafa1 decimalNumberByAdding:jiafa2];
//NSDecimalNumber*jianfa= [jianfa1 decimalNumberBySubtracting:jianfa2];
@property (nonatomic, copy) NSString * operatorBeforeString;
@property (nonatomic, strong) NSMutableString *inputString;
@end
@implementation PPSSCollectKeyboardView
- (instancetype)initWithBtnWidth:(CGFloat)width betweenWidth:(CGFloat)betweenWidth {
    if (self = [super init]) {
        _btnWidth = width;
        _betweenWidth = betweenWidth;
        _currentOperation = -1;
        _nornalColor = ColorHexadecimal(kMainBackground_Color, 1.);
        _selectColor = ColorHexadecimal(Color_APP_MAIN, 1.);
        [self _layoutMainView];
    }
    return self;
}
- (void)keyboardClick:(UIButton *)btn {
    NSRange dotRange = [self.inputString rangeOfString:@"."];
    if (dotRange.location != NSNotFound) {
        if (btn.tag == 211) {
            return;
        }else if(self.inputStr.length - dotRange.location > 2) {
            return;
        }
    }
    NSInteger tag = btn.tag - 200;
    if (tag <= 9) {
        if (self.inputString.length == 1 && [self.inputString rangeOfString:@"0"].location != NSNotFound) {
            [self.inputString deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        [self.inputString appendFormat:@"%ld",tag];
        self.inputStr = self.inputString;
    }else {
        if (tag == 10) {
            if (self.inputString.length == 0 || [self.inputString rangeOfString:@"0"].location != 0) {
                [self.inputString appendString:@"0"];
                self.inputStr = self.inputString;
            }
        }else {
            if (self.inputString.length > 0) {
                [self.inputString appendString:@"."];
                self.inputStr = self.inputString;
            }
        }
    }
}
- (void)keyboardOperatorClick:(UIButton *)btn {
    if (btn.tag == 212) {
        if (self.inputString.length > 0) {
            [self.inputString deleteCharactersInRange:NSMakeRange(self.inputString.length - 1, 1)];
            self.inputStr = self.inputString;
        }
    }else {//1减 2加
        if (btn.selected) {
            [self numberOperator];
            _currentOperation = -1;
            self.operatorBeforeString = nil;
            btn.selected = NO;
            btn.layer.borderColor = _nornalColor.CGColor;
            [_collectBtn setTitle:@"收款" forState: UIControlStateNormal];
        }else {
            if (_currentOperation != -1) {
                [self numberOperator];
                self.operatorBeforeString = self.inputStr;
            }else {
                self.operatorBeforeString = self.inputString;
              [self.inputString deleteCharactersInRange:NSMakeRange(0, self.inputString.length)];
            }
            
            [self changeOperator:btn];
            _currentOperation = btn.tag - 212;
            [_collectBtn setTitle:@"=" forState: UIControlStateNormal];
        }
    }
}
- (void)numberOperator {
    BOOL isBefore = [self.operatorBeforeString isHasValue];
    BOOL isCurrent = [self.inputString isHasValue];
    if (isBefore && !isCurrent) {
        self.inputStr = self.operatorBeforeString;
    }
    if (!isBefore && isCurrent) {
         self.inputStr = self.inputString;
    }
    if (isBefore && isCurrent) {
        NSDecimalNumber*number1 = [NSDecimalNumber decimalNumberWithString:self.operatorBeforeString];
        NSDecimalNumber*number2 = [NSDecimalNumber decimalNumberWithString:self.inputString];
        if (_currentOperation == 1) {
            NSDecimalNumber*jianfa= [number1 decimalNumberBySubtracting:number2];
            self.inputStr = jianfa.stringValue;
        }else {
            NSDecimalNumber*jiafa= [number1 decimalNumberByAdding:number2];
            self.inputStr = jiafa.stringValue;
        }
    }
    [self.inputString deleteCharactersInRange:NSMakeRange(0, self.inputString.length)];
}
- (void)collectBtnClick {
    if (_currentOperation != -1) {
        [self numberOperator];
        UIButton *otherBtn = [self viewWithTag:212 + _currentOperation];
        otherBtn.selected = NO;
        otherBtn.layer.borderColor = _nornalColor.CGColor;
        _currentOperation = -1;
        self.operatorBeforeString = nil;
        [_collectBtn setTitle:@"收款" forState: UIControlStateNormal];
    }else {
        
    }
}
- (void)changeInputType:(NSString *)title {
    self.operatorBeforeString = nil;
    if (self.inputString.length > 0) {
        [self.inputString deleteCharactersInRange:NSMakeRange(0, self.inputString.length)];
    }
    if (_currentOperation != -1) {
        UIButton *otherBtn = [self viewWithTag:212 + _currentOperation];
        otherBtn.selected = NO;
        otherBtn.layer.borderColor = _nornalColor.CGColor;
        _currentOperation = -1;
        [_collectBtn setTitle:@"收款" forState: UIControlStateNormal];
    }
}
- (void)changeOperator:(UIButton *)btn {
    btn.selected = YES;
    btn.layer.borderColor = _selectColor.CGColor;
    if (_currentOperation != -1) {
        UIButton *otherBtn = [self viewWithTag:212 + _currentOperation];
        otherBtn.selected = NO;
        otherBtn.layer.borderColor = _nornalColor.CGColor;
    }
}
#pragma mark -init view
- (void)_layoutMainView {
    self.inputString = [[NSMutableString alloc]init];
    for (int i = 0; i < 4; i ++) {
        NSInteger max = i == 3?2:3;
        for (int j = 0;j < max ;j++ ) {
            UIButton *btn = [self customKeyboardBtnWithIndex:i * 3 + j + 1];
            btn.frame = CGRectMake(_betweenWidth + (_betweenWidth + _btnWidth) * j,_betweenWidth + (_betweenWidth + _btnWidth) * i , _btnWidth, _btnWidth);
            [self addSubview:btn];
        }
    }
    
    UIButton *deleteBtn = [self customKeyboardImgBtnWithImg:@"fanhui_shanchu" tag:12];
    deleteBtn.frame = CGRectMake(_betweenWidth + (_betweenWidth + _btnWidth) * 2,_betweenWidth + (_betweenWidth + _btnWidth) * 3 , _btnWidth, _btnWidth);
    [self addSubview:deleteBtn];
    
    UIButton *jianBtn = [self customKeyboardImgBtnWithImg:@"sy_jian" tag:13];
    jianBtn.frame = CGRectMake(_betweenWidth + (_betweenWidth + _btnWidth) * 3,_betweenWidth , _btnWidth, _btnWidth);
    [self addSubview:jianBtn];
    
    UIButton *jiaBtn = [self customKeyboardImgBtnWithImg:@"sy_jia" tag:14];
    jiaBtn.frame =  CGRectMake(_betweenWidth + (_betweenWidth + _btnWidth) * 3,_betweenWidth + (_betweenWidth + _btnWidth) , _btnWidth, _btnWidth);
    [self addSubview:jiaBtn];
    CGFloat font = WIDTH_RACE_6S(25);
    _collectBtn = [PPSSPublicViewManager initAPPThemeBtn:@"收款" font:font target:self action:@selector(collectBtnClick)];
    _collectBtn.titleLabel.numberOfLines = 0;
    _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, (_btnWidth - font) / 2, 0, (_btnWidth - font) / 2);
    ViewRadius(_collectBtn, 3.0);
    _collectBtn.frame = CGRectMake(_betweenWidth + (_betweenWidth + _btnWidth) * 3,_betweenWidth + (_betweenWidth + _btnWidth) * 2 , _btnWidth, _btnWidth * 2 + _betweenWidth);
    [self addSubview:_collectBtn];

}

- (UIButton *)customKeyboardImgBtnWithImg:(NSString *)img tag:(NSInteger)tag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:img selectedImage:nil target:self action:@selector(keyboardOperatorClick:) textfont:WIDTH_RACE_6S(29) textColor:ColorHexadecimal(Color_Text_3333, 1.0) backgroundColor:nil backgroundImage:nil];
    ViewRadius(btn, 3.0);
    ViewBorderLayer(btn, _nornalColor, LINEVIEW_WIDTH);
    btn.tag = 200 + tag;
    return btn;
}


- (UIButton *)customKeyboardBtnWithIndex:(NSInteger)index {
    NSString *title = nil;
    if (index == 11) {
        title = @".";
    }else {
        title = NSStringFormat(@"%ld",index == 10? 0:index);
    }
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:self action:@selector(keyboardClick:) textfont:WIDTH_RACE_6S(29) textColor:ColorHexadecimal(Color_Text_3333, 1.0) backgroundColor:nil backgroundImage:nil];
    ViewRadius(btn, 3.0);
    ViewBorderLayer(btn, _nornalColor, LINEVIEW_WIDTH);
    btn.tag = 200 + index;
    return btn;
}

@end
