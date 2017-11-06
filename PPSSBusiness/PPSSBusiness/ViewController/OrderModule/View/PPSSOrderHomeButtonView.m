//
//  PPSSOrderHomeButtonView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeButtonView.h"

@implementation PPSSOrderHomeButtonView
{
    OrderHomeButtonType _type;
    UILabel *_textLbl;
}

-(instancetype)initWithType:(OrderHomeButtonType)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupTitle:(NSString *)title {
    _textLbl.text = title;
}
- (NSString *)dateString {
    return _textLbl.text;
}
- (void)_layoutMainView {
    UILabel *textLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:1];
    textLbl.adjustsFontSizeToFitWidth = YES;
    _textLbl = textLbl;
    [self addSubview:textLbl];
    WS(ws)
    [_textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.centerX.equalTo(ws).with.offset(- 8);
        make.left.greaterThanOrEqualTo(ws).with.offset(10);
        make.right.lessThanOrEqualTo(ws).with.offset(-18);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrowdown")];
    [self addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLbl.mas_right).with.offset(8);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(17 / 2.0);
    }];
    
    if (_type == OrderHomeButtonType_Date) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(textLbl.mas_left);
            make.right.equalTo(arrowImageView.mas_right);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(ws);
        }];
        _textLbl.textColor = lineView.backgroundColor;
        _textLbl.text = [[NSDate getTodayDate]dateTransformToString:@"yyyy-MM-dd"];
    }else {
        _textLbl.text = @"全部门店";
    }
}
@end
