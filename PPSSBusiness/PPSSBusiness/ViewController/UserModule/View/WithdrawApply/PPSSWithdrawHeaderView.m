//
//  PPSSWithdrawHeaderView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWithdrawHeaderView.h"
@interface PPSSWithdrawHeaderView ()<UITextFieldDelegate>
@property (nonatomic, weak) UILabel *balanceLbl;
@property (nonatomic, weak) UILabel *shareLbl;
@property (nonatomic, weak) UITextField *moneyTextField;
@end
@implementation PPSSWithdrawHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        [self _layoutMainView];
    }
    return self;
}
- (void)applyActionEvent {
    if (self.withdrawBlock) {
        self.withdrawBlock(self.moneyTextField.text);
    }
}
- (void)setupMoneyViewWithBalance:(NSString *)balance share:(NSString *)share {
    self.balanceLbl.text = balance;
    self.shareLbl.text = share;
}

- (void)_layoutMainView {
    UIView *moneyView = [self _layoutMoneyView];
    [self addSubview:moneyView];
    UIView *inputView = [self _layoutInputView];
    [self addSubview:inputView];
    UIView *sectionView = [self _layoutSectionView];
    [self addSubview:sectionView];
    WS(ws)
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(150);
    }];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(moneyView);
        make.top.equalTo(moneyView.mas_bottom);
        make.height.mas_equalTo(70);
    }];
    
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(moneyView);
        make.bottom.equalTo(ws);
        make.top.equalTo(inputView.mas_bottom);
    }];
    
}
- (UIView *)_layoutMoneyView {
    UIView *moneyView = [[UIView alloc]init];
    moneyView.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
    UIView *balanceView = [self customMoneyView:@"商户余额" img:@"withdrawbalance" tag:1];
    [moneyView addSubview:balanceView];
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(moneyView);
        make.right.equalTo(moneyView.mas_centerX);
    }];
    UIView *shareView = [self customMoneyView:@"消费分润" img:@"withdrawshare" tag:2];
    [moneyView addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(moneyView);
        make.left.equalTo(moneyView.mas_centerX);
    }];
    return moneyView;
}
- (UIView *)customMoneyView:(NSString *)title img:(NSString *)img tag:(NSInteger)tag {
    UIView *view = [[UIView alloc]init];
    UIImageView *iconImg = [[UIImageView alloc]initWithImage: ImageNameInit(img)];
    [view addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(30);
        make.height.mas_equalTo(77 / 2.0);
        make.centerX.equalTo(view);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:title font:12 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    [view addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).with.offset(11);
        make.centerX.equalTo(view);
    }];
    UILabel *moneyLbl = [LSKViewFactory initializeLableWithText:@"￥0.00" font:12 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    if (tag == 1) {
        self.balanceLbl = moneyLbl;
    }else {
        self.shareLbl = moneyLbl;
    }
    [view addSubview:moneyLbl];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).with.offset(8);
        make.centerX.equalTo(view);
    }];
    return view;
}


- (UIView *)_layoutInputView {
    UIView *inputView = [[UIView alloc]init];
    UIButton *applyBtn = [PPSSPublicViewManager initAPPThemeBtn:@"申请提现" font:12 target:self action:@selector(applyActionEvent)];
    ViewRadius(applyBtn, 3.0);
    [inputView addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inputView.mas_right).with.offset(-15);
        make.top.equalTo(inputView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    UITextField *textField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入要提现的金额" textFont:12 textColor:ColorHexadecimal(Color_Text_6666, 1.0) placeholderColor:ColorHexadecimal(Color_Text_6666, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeDecimalPad cleanModel:0];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    ViewRadius(textField, 3.0);
    ViewBorderLayer(textField, ColorHexadecimal(Color_APP_MAIN, 1.0), LINEVIEW_WIDTH);
    self.moneyTextField = textField;
    [inputView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputView).with.offset(15);
        make.top.bottom.equalTo(applyBtn);
        make.right.equalTo(applyBtn.mas_left).with.offset(-8);
    }];
    
    UILabel *remarkLbl = [PPSSPublicViewManager initLblForColor9999:@"提示信息:微信消息提示如何能不显示消息内容详情"];
    [inputView addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField);
        make.top.equalTo(textField.mas_bottom);
        make.bottom.equalTo(inputView);
    }];
    
    return inputView;
}

- (UIView *)_layoutSectionView {
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"提现记录" textAlignment:0];
    [sectionView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView).with.offset(15);
        make.centerY.equalTo(sectionView);
    }];
    return sectionView;
}
#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
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
@end
