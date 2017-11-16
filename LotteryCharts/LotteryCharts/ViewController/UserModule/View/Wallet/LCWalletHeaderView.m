//
//  LCWalletHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWalletHeaderView.h"

@implementation LCWalletHeaderView
{
    UILabel *_moneyLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(0xf6a623, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupMoney:(NSString *)money {
    _moneyLbl.text = money;
}
- (void)withdrawEvent {
    if (self.headerBlock) {
        self.headerBlock(0);
    }
}
- (void)_layoutMainView {
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"赏金" font:20 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(32);
        make.top.equalTo(ws).with.offset(82);
    }];
    
    UILabel *moneyLbl = [LSKViewFactory initializeLableWithText:@"￥0.00" font:20 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _moneyLbl = moneyLbl;
    [self addSubview:moneyLbl];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(30);
        make.bottom.equalTo(ws).with.offset(-34);
    }];
    UILabel *goldLbl = [LSKViewFactory initializeLableWithText:@"金币" font:12 textColor:ColorRGBA(255, 255, 255, 0.5) textAlignment:0 backgroundColor:nil];
    [self addSubview:goldLbl];
    [goldLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLbl.mas_right).with.offset(5);
        make.bottom.equalTo(moneyLbl.mas_bottom).with.offset(-2);
    }];
    
    UIButton *withdrawBtn = [LSKViewFactory initializeButtonWithTitle:@"去提现" nornalImage:@"arrow_white" selectedImage:@"arrow_white" target:self action:@selector(withdrawEvent) textfont:12 textColor:ColorRGBA(255, 255, 255, 0.5) backgroundColor:nil backgroundImage:nil];
    withdrawBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    withdrawBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
    withdrawBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -38);
    [self addSubview:withdrawBtn];
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLbl.mas_top);
        make.right.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
}
@end
