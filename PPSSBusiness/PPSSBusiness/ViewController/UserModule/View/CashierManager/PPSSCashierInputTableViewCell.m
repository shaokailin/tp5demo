//
//  PPSSCashierInputTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierInputTableViewCell.h"
@interface PPSSCashierInputTableViewCell()<UITextFieldDelegate>
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, assign) NSInteger type;
@end
@implementation PPSSCashierInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupInputContentWithTitle:(NSString *)title content:(NSString *)content index:(NSInteger)index {
    self.titleLbl.text = title;
    if (KJudgeIsNullData(content)) {
        self.textField.text = content;
    }
    if (_type != index) {
        _type = index;
        [self changeTextFieldWithIndex:index];
    }
}
- (void)changeTextFieldWithIndex:(NSInteger)index {
    if (index > 1) {
        self.textField.secureTextEntry = YES;
        self.textField.keyboardType = UIKeyboardTypeAlphabet;
    }else {
        if (index == 0) {
            self.textField.keyboardType = UIKeyboardTypeDefault;
        }else {
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        self.textField.secureTextEntry = NO;
    }
    self.textField.placeholder = [self returnPlaceholderWithIndex:index];
}
- (NSString *)returnPlaceholderWithIndex:(NSInteger)index {
    NSString *placeholder = nil;
    switch (index) {
        case 0:
        {
            placeholder = @"请输入收银员姓名";
             break;
        }
        case 1:
        {
            placeholder = @"请输入手机号码";
            break;
        }
        case 2:
        {
            placeholder = @"请输入密码";
            break;
        }
        case 3:
        {
            placeholder = @"请再次输入密码";
            break;
        }
        default:
            break;
    }
    return placeholder;
}
- (void)_layoutMainView {
    _type = 0;
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    self.titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(80);
    }];
    UITextField *textField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入收银员姓名" textFont:12 textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_6666, 1.0) textAlignment:2 borStyle:0 returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeDefault cleanModel:0];
    self.textField = textField;
    [self.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(10);
        make.top.bottom.equalTo(ws.contentView);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
    
    [[[textField rac_textSignal]skip:1]subscribeNext:^(NSString * _Nullable x) {
        [ws textDidExit:x];
    }];
}
- (void)textDidExit:(NSString *)text {
    if (self.inputBlock) {
        self.inputBlock(self, text);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_type == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.length != 1) {
        if (range.location > (_type == 1 ? 10 : 19)) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
