//
//  PPSSOrderHomeScreenView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeScreenView.h"
static const NSInteger kContentViewHeight = 229;
@implementation PPSSOrderHomeScreenView
{
    NSInteger _payTypeSelectIndex;
    NSInteger _payStateIndex;
    OrderHomeScreenBlock _clickBlock;
    UIView *_contentView;
    UIView *_bgView;
    UIColor *_appColor;
}
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
//        [self _layoutMainView];
//    }
//    return self;
//}
- (instancetype)initWithEventBlock:(OrderHomeScreenBlock)clickBlock {
    if (self = [super init]) {
        _payStateIndex = -1;
        _clickBlock = clickBlock;
        _payTypeSelectIndex = -1;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self _layoutMainView];
    }
    return self;
}
- (void)showInView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT - kContentViewHeight, SCREEN_WIDTH, kContentViewHeight);
        _bgView.alpha = 1;
    }];
}
- (void)hidenView {
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight);
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [_bgView addGestureRecognizer:tap];
    _bgView.alpha = 0;
    [self addSubview:_bgView];
    [self _layoutContentView];
}
- (void)_layoutContentView {
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight)];
    contentView.backgroundColor = COLOR_WHITECOLOR;
    _contentView = contentView;
    [self addSubview:contentView];
    UILabel *payTypeTitleLbl = [PPSSPublicViewManager initLblForColor3333:@"支付方式" textAlignment:0];
    payTypeTitleLbl.font = FontBoldInit(12);
    [_contentView addSubview:payTypeTitleLbl];
    [payTypeTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(15);
        make.top.right.equalTo(contentView);
        make.height.mas_equalTo(50);
    }];
    CGFloat betweent = (SCREEN_WIDTH - 30 - 60 * 4 ) / 3.0;
    UIButton *alipayBtn = [self customBtnWithTitle:@"支付宝" tag:200];
    [_contentView addSubview:alipayBtn];
    
    UIButton *wxBtn = [self customBtnWithTitle:@"微信" tag:201];
    [_contentView addSubview:wxBtn];
    
    UIButton *chuBtn = [self customBtnWithTitle:@"储值" tag:202];
    [_contentView addSubview:chuBtn];
    
    UIButton *yuBtn = [self customBtnWithTitle:@"余额" tag:203];
    [_contentView addSubview:yuBtn];
    
    [alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payTypeTitleLbl);
        make.top.equalTo(payTypeTitleLbl.mas_bottom);
        make.size.mas_equalTo (CGSizeMake(60, 25));
    }];
    
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alipayBtn.mas_right).with.offset(betweent);
        make.top.equalTo(alipayBtn);
        make.width.height.equalTo(alipayBtn);
    }];
    
    [chuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxBtn.mas_right).with.offset(betweent);
        make.top.equalTo(alipayBtn);
        make.width.height.equalTo(alipayBtn);
    }];
    
    [yuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chuBtn.mas_right).with.offset(betweent);
        make.top.equalTo(alipayBtn);
        make.width.height.equalTo(alipayBtn);
    }];
    
    UILabel *payStateTitleLbl = [PPSSPublicViewManager initLblForColor3333:@"交易状态" textAlignment:0];
    payTypeTitleLbl.font = FontBoldInit(12);
    [_contentView addSubview:payStateTitleLbl];
    [payStateTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payTypeTitleLbl);
        make.height.mas_equalTo(50);
        make.top.equalTo(alipayBtn.mas_bottom);
    }];
    UIButton *successBtn = [self customBtnWithTitle:@"支付成功" tag:300];
    [_contentView addSubview:successBtn];
    
    UIButton *errorBtn = [self customBtnWithTitle:@"未支付" tag:301];
    [_contentView addSubview:errorBtn];
    
    [successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payStateTitleLbl);
        make.top.equalTo(payStateTitleLbl.mas_bottom);
        make.width.height.equalTo(alipayBtn);
    }];
    
    [errorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(successBtn.mas_right).with.offset(betweent);
        make.top.equalTo(successBtn);
        make.width.height.equalTo(alipayBtn);
    }];
    _appColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = _appColor;
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView).with.offset(-44);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    UIButton *resetBtn = [LSKViewFactory initializeButtonWithTitle:@"重置" nornalImage:nil selectedImage:nil target:self action:@selector(resetClickEvent) textfont:15 textColor:_appColor backgroundColor:nil backgroundImage:nil];
    [_contentView addSubview:resetBtn];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(contentView);
        make.top.equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(190 / 2.0);
    }];
    UIButton *sureBtn = [PPSSPublicViewManager initAPPThemeBtn:@"确定" font:15 target:self action:@selector(sureSelectEvent)];
    [_contentView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(resetBtn.mas_right);
        make.top.bottom.equalTo(resetBtn);
        make.right.equalTo(contentView);
    }];
}

- (UIButton *)customBtnWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIColor *color = ColorHexadecimal(Color_Text_6666, 1.0);
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:self action:@selector(selectBtnClick:) textfont:10 textColor:color backgroundColor:nil backgroundImage:nil];
    btn.tag = tag;
    [btn setTitleColor:COLOR_WHITECOLOR forState:UIControlStateSelected];
    ViewRadius(btn, 3);
    ViewBorderLayer(btn, color, LINEVIEW_WIDTH);
    return btn;
}
- (void)resetClickEvent {
    if (_payTypeSelectIndex != -1) {
        [self cancleSelect:_payTypeSelectIndex];
        _payTypeSelectIndex = -1;
    }
    if (_payStateIndex != -1) {
        [self cancleSelect:_payStateIndex];
        _payStateIndex = -1;
    }
}
- (void)cancleSelect:(NSInteger)tag {
    UIButton *otherBtn = [_contentView viewWithTag:tag];
    otherBtn.selected = NO;
    otherBtn.layer.borderWidth = LINEVIEW_WIDTH;
    otherBtn.backgroundColor = COLOR_WHITECOLOR;
}
- (void)sureSelectEvent {
    if (_clickBlock) {
        _clickBlock(_payTypeSelectIndex,_payStateIndex);
    }
    [self hidenView];
}
- (void)selectBtnClick:(UIButton *)btn {
    if (!btn.selected) {
        UIButton *otherBtn = nil;
        if (btn.tag < 300) {
            if (_payTypeSelectIndex != -1) {
                otherBtn = [_contentView viewWithTag:_payTypeSelectIndex];
            }
            _payTypeSelectIndex = btn.tag;
        }else {
            if (_payStateIndex != -1) {
                otherBtn = [_contentView viewWithTag:_payStateIndex];
            }
            _payStateIndex = btn.tag;
        }
        btn.selected = YES;
        btn.backgroundColor = _appColor;
        btn.layer.borderWidth = 0;
        if (otherBtn) {
            otherBtn.selected = NO;
            otherBtn.layer.borderWidth = LINEVIEW_WIDTH;
            otherBtn.backgroundColor = COLOR_WHITECOLOR;
        }
    }else {
        btn.selected = NO;
        btn.layer.borderWidth = LINEVIEW_WIDTH;
        btn.backgroundColor = COLOR_WHITECOLOR;
        if (btn.tag < 300) {
            _payTypeSelectIndex = -1;
        }else {
            _payStateIndex = -1;
        }
    }
}

@end
