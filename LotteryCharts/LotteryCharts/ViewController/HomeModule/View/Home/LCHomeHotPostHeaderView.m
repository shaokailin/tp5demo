//
//  LCHomeHotPostHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHotPostHeaderView.h"

@implementation LCHomeHotPostHeaderView
{
    UILabel *_countLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupLineCount:(NSString *)count {
    NSString *string = NSStringFormat(@"在线人数：%@",count);
    _countLbl.text = string;
    CGFloat width = [string calculateTextWidth:10] + 36;
    [_countLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}
- (void)_layoutMainView {
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
    WS(ws)
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(ws).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(5, 20));
    }];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"热帖" font:14 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).with.offset(4);
        make.centerY.equalTo(lineView);
    }];
    
    UILabel *countLbl = [LSKViewFactory initializeLableWithText:@"在线人数：0" font:10 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:ColorHexadecimal(0xbfbfbf, 1.0)];
    ViewBoundsRadius(countLbl, 8);
    _countLbl = countLbl;
    [self addSubview:countLbl];
    [countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-10);
        make.centerY.equalTo(lineView);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(56 + 36);
    }];
    
}

@end
