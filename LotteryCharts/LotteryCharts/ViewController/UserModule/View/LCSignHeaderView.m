//
//  LCSignHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSignHeaderView.h"

@implementation LCSignHeaderView
{
    UIButton *_signBtn;
    UILabel *_signTitleLbl;
    UILabel *_signDateLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _isSign = NO;
        [self _layoutMainView];
    }
    return self;
}
- (void)setIsSign:(BOOL)isSign {
    if (isSign != _isSign) {
        _isSign = isSign;
        [self changeSignState];
    }
}
- (void)changeSignState {
    if (_isSign) {
        [_signBtn setImage:ImageNameInit(@"signgou") forState:UIControlStateNormal];
        _signBtn.userInteractionEnabled = NO;
        _signTitleLbl.text = @"今日已签到";
    }else {
        [_signBtn setImage:nil forState:UIControlStateNormal];
        _signBtn.userInteractionEnabled = YES;
        [_signBtn setTitle:@"未签到" forState:UIControlStateNormal];
        _signTitleLbl.text = @"今日未签到";
    }
}
- (void)signForToday:(NSInteger)week {
    UIButton *weekBtn = [self viewWithTag:200 + week];
    UILabel *weekLbl = [weekBtn viewWithTag:300 + week];
    weekLbl.text = @"已签";
    weekLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
}
- (void)changeSingAll:(NSInteger)allSign {
    _signDateLbl.text = NSStringFormat(@"本周您已连续签到%zd天",allSign);
}
- (void)_layoutMainView {
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = ColorHexadecimal(0xf6a623, 1.0);
    [self addSubview:headerView];
    WS(ws)
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws);
        make.height.mas_equalTo(250);
    }];
    UIView *circleView = [[UIView alloc]init];
    circleView.backgroundColor = ColorHexadecimal(0xffffff, 0.5);
    ViewRadius(circleView, 50);
    [headerView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
        make.width.height.mas_equalTo(100);
    }];
    UIButton *signBtn = [LSKViewFactory initializeButtonWithTitle:@"未签到" target:self action:@selector(signClick) textfont:20 textColor:ColorHexadecimal(0xd66440,1.0)];
    [signBtn setBackgroundColor:ColorHexadecimal(0xffffff, 1.0)];
    ViewRadius(signBtn, 45);
    _signBtn = signBtn;
    [circleView addSubview:signBtn];
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
        make.width.height.mas_equalTo(90);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"今日已签到" font:15 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _signTitleLbl = titleLbl;
    [headerView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(circleView.mas_bottom).with.offset(8);
        make.centerX.equalTo(headerView);
    }];
    UILabel *detailLbl = [LSKViewFactory initializeLableWithText:@"本周您已连续签到0天" font:10 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _signDateLbl = detailLbl;
    [headerView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).with.offset(8);
        make.centerX.equalTo(headerView);
    }];
    CGFloat width = 42;
    CGFloat height = 50;
    CGFloat between = (SCREEN_WIDTH - width * 7) / 8.0;
    UIButton *btn1 = [self customBtnView:1];
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(between);
        make.top.equalTo(headerView.mas_bottom).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    UIButton *btn2 = [self customBtnView:2];
    [self addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn1.mas_right).with.offset(between);
    }];
    UIButton *btn3 = [self customBtnView:3];
    [self addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn2.mas_right).with.offset(between);
    }];
    UIButton *btn4 = [self customBtnView:4];
    [self addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn3.mas_right).with.offset(between);
    }];
    UIButton *btn5 = [self customBtnView:5];
    [self addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn4.mas_right).with.offset(between);
    }];
    UIButton *btn6 = [self customBtnView:6];
    [self addSubview:btn6];
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn5.mas_right).with.offset(between);
    }];
    UIButton *btn7 = [self customBtnView:7];
    [self addSubview:btn7];
    [btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(btn1);
        make.left.equalTo(btn6.mas_right).with.offset(between);
    }];
}

- (UIButton *)customBtnView:(NSInteger)flag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:nil action:nil textfont:0 textColor:nil backgroundColor:ColorHexadecimal(0xffffff, 0.9) backgroundImage:0];
    ViewRadius(btn, 5.0)
    btn.tag = flag + 200;
    UILabel *topTitle = [LSKViewFactory initializeLableWithText:NSStringFormat(@"%zd天",flag) font:12 textColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 backgroundColor:nil];
    [btn addSubview:topTitle];
    [topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn).with.offset(8);
        make.centerX.equalTo(btn);
    }];
    
    UILabel *bottonLbl = [LSKViewFactory initializeLableWithText:@"未签" font:15 textColor:ColorHexadecimal(0x959595, 1.0) textAlignment:0 backgroundColor:nil];
    bottonLbl.tag = 300 + flag;
    [btn addSubview:bottonLbl];
    [bottonLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitle.mas_bottom).with.offset(4);
        make.centerX.equalTo(btn);
    }];
    return btn;
}
- (void)signClick {
    
}

@end
