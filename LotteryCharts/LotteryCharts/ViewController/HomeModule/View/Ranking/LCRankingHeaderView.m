//
//  LCRankingHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingHeaderView.h"

@implementation LCRankingHeaderView
{
    NSInteger _currentType;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)changeClick:(UIButton *)brn {
    if (!brn.selected) {
        UIButton *otherBtn = [self viewWithTag:200 + _currentType];
        otherBtn.selected = NO;
        brn.selected = YES;
        _currentType = brn.tag - 200;
        if (self.headerBlock) {
            self.headerBlock(_currentType);
        }
    }
}
- (void)_layoutMainView {
    _currentType = 0;
    WS(ws)
    UIButton *vipBtn = [self customBtnView:@"VIP榜" flag:200];
    vipBtn.selected = YES;
    [self addSubview:vipBtn];
    
    UIButton *renBtn = [self customBtnView:@"人气榜" flag:201];
    [self addSubview:renBtn];
    
    UIButton *publishBtn = [self customBtnView:@"发布榜" flag:202];
    [self addSubview:publishBtn];
    UIButton *glodBtn = [self customBtnView:@"赏金榜" flag:203];
    [self addSubview:glodBtn];
    [vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(ws);
    }];
    [renBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipBtn.mas_right);
        make.top.bottom.width.equalTo(vipBtn);
    }];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renBtn.mas_right);
        make.top.bottom.width.equalTo(renBtn);
    }];
    [glodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(publishBtn.mas_right);
        make.top.bottom.width.equalTo(publishBtn);
        make.right.equalTo(ws);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(0xFFEDCF, 1.0);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(kLineView_Height);
    }];
}
- (UIButton *)customBtnView:(NSString *)title flag:(NSInteger)flag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title target:self action:@selector(changeClick:) textfont:15 textColor:ColorHexadecimal(0xbfbfbf, 1.0)];
    btn.tag = flag;
    [btn setTitleColor:ColorHexadecimal(0xf6a623, 1.) forState:UIControlStateSelected];
    return btn;
}
@end
