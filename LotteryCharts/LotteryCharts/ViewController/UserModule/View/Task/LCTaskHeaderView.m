//
//  LCTaskHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTaskHeaderView.h"

@implementation LCTaskHeaderView
{
    UILabel *_moneyLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(0xa0a0a0, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupMoney:(NSString *)money {
    _moneyLbl.text = money;
}
- (void)_layoutMainView {
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"做任务赢银币" font:12 textColor:ColorHexadecimal(0xf6a623, 1.0) textAlignment:0 backgroundColor:nil];
    [bottomView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(20);
        make.centerY.equalTo(bottomView);
    }];
    [self addSubview:bottomView];
    WS(ws)
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(ws);
        make.height.mas_equalTo(42);
    }];
    UILabel *nameLbl = [LSKViewFactory initializeLableWithText:nil font:20 textColor:ColorHexadecimal(0xffffff, 1.0) textAlignment:1 backgroundColor:nil];
    _moneyLbl = nameLbl;
    [self addSubview:nameLbl];
    
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top).with.offset(-32);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *titleLbl1 = [LSKViewFactory initializeLableWithText:@"银币" font:20 textColor:ColorHexadecimal(0x434343,1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl1];
    [titleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nameLbl.mas_top).with.offset(-14);
        make.centerX.equalTo(ws);
    }];
}

@end
