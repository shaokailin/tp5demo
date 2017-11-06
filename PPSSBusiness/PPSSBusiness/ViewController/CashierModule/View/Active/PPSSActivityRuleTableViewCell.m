//
//  PPSSActivityRuleTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/25.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityRuleTableViewCell.h"
@interface PPSSActivityRuleTableViewCell()<UITextFieldDelegate>
{
    UITextField *_pointTextField;
    UITextField *_moneyTextField;
    BOOL _isEdit;
}
@end
@implementation PPSSActivityRuleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        _isEdit = YES;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupPointValue:(NSString *)point money:(NSString *)money isEdit:(BOOL)isEdit  {
    _moneyTextField.text = money;
    _pointTextField.text = point;
    if (_isEdit != isEdit) {
        _isEdit = isEdit;
        _moneyTextField.userInteractionEnabled = NO;
        _pointTextField.userInteractionEnabled = NO;
    }
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"兑换规则" textAlignment:1];
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.contentView).with.offset(15);
    }];
    
    UILabel *leftLbl = [PPSSPublicViewManager initLblForColor6666:@"集点满"];
    [self.contentView addSubview:leftLbl];
    [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(26);
    }];
    
    UITextField *pointField = [self customTextField:@"如100"];
    _pointTextField = pointField;
    [self.contentView addSubview:pointField];
    [pointField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLbl.mas_right).with.offset(3);
        make.centerY.equalTo(leftLbl);
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(80), 30));
    }];
    
    UILabel *middleLbl = [PPSSPublicViewManager initLblForColor6666:@"积分可兑换"];
    [self.contentView addSubview:middleLbl];
    [middleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointField.mas_right).with.offset(3);
        make.centerY.equalTo(leftLbl);
    }];
    
    UITextField *moneyField = [self customTextField:@"如50"];
    moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    moneyField.delegate = self;
    _moneyTextField = moneyField;
    [self.contentView addSubview:moneyField];
    [moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleLbl.mas_right).with.offset(3);
        make.centerY.equalTo(leftLbl);
        make.size.equalTo(pointField);
    }];
    
    UILabel *rightLbl = [PPSSPublicViewManager initLblForColor6666:@"本店余额"];
    [self.contentView addSubview:rightLbl];
    [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyField.mas_right).with.offset(3);
        make.centerY.equalTo(leftLbl);
    }];
    @weakify(self)
    [[pointField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if (self.ruleBlock) {
            self.ruleBlock(1, x);
        }
    }];
    [[moneyField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        if (self.ruleBlock) {
            self.ruleBlock(2, x);
        }
    }];
    
    
}
- (UITextField *)customTextField:(NSString *)placeholder {
    UITextField *textField = [LSKViewFactory initializeTextFieldWithDelegate:nil text:nil placeholder:placeholder textFont:12 textColor:ColorHexadecimal(Color_Text_9999, 1.0) placeholderColor:ColorHexadecimal(Color_Text_9999, 1.0) textAlignment:0 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDefault keyBoard:UIKeyboardTypeNumberPad cleanModel:0];
    textField.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    textField.layer.borderColor = ColorHexadecimal(0xcdcdcd, 1.0).CGColor;
    return textField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (range.length != 1) {
        NSRange dotRange = [textField.text rangeOfString:@"."];
        if (dotRange.location != NSNotFound) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            if (dotRange.location < range.location) {
                if (textField.text.length - dotRange.location > 2) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
