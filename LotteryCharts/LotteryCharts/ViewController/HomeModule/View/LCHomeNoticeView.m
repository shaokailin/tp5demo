//
//  LCHomeNoticeView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeNoticeView.h"

@implementation LCHomeNoticeView
{
    UILabel *_contentLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"home_notice")];
    [self addSubview:arrowImageView];
    WS(ws)
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(17);
    }];
    
    UILabel *titleLble = [LSKViewFactory initializeLableWithText:@"公告:" font:11 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLble];
    [titleLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.mas_right).with.offset(5);
        make.centerY.equalTo(ws);
    }];
    
    UILabel *contentLbl = [LSKViewFactory initializeLableWithText:@"恭喜ABV用户获得获得获得" font:11 textColor:ColorHexadecimal(0x959595, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl = contentLbl;
    [self addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLble.mas_right).with.offset(8);
        make.centerY.equalTo(ws);
        make.right.lessThanOrEqualTo(ws.mas_right).with.offset(-10);
    }];
}

@end
