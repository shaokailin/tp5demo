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
    
}
- (void)_layoutMainView {
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"赏金" font:20 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(32);
        make.top.equalTo(ws).with.offset(82);
    }];
    
}
@end
