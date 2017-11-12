//
//  LCHomeFuncView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeFuncView.h"

@implementation LCHomeFuncView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIButton *rankingBtn = [self _customBtnViewWithTitle:@"排行" image:@"home_ranking" flag:200];
    [self addSubview:rankingBtn];
    UIButton *liveBtn = [self _customBtnViewWithTitle:@"直播" image:@"home_live" flag:201];
    [self addSubview:liveBtn];
    UIButton *historyBtn = [self _customBtnViewWithTitle:@"历史" image:@"home_history" flag:202];
    [self addSubview:historyBtn];
    UIButton *payBtn = [self _customBtnViewWithTitle:@"充值" image:@"home_pay" flag:203];
    [self addSubview:payBtn];
    UIView *lineView1 = [LSKViewFactory initializeLineView];
    [self addSubview:lineView1];
    UIView *lineView2 = [LSKViewFactory initializeLineView];
    [self addSubview:lineView2];
    UIView *lineView3 = [LSKViewFactory initializeLineView];
    [self addSubview:lineView3];
    WS(ws)
    [rankingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(ws);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rankingBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(kLineView_Height, 21));
        make.centerY.equalTo(ws);
    }];
    
    [liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right);
        make.top.bottom.equalTo(rankingBtn);
        make.width.equalTo(rankingBtn);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liveBtn.mas_right);
        make.size.equalTo(lineView1);
        make.centerY.equalTo(ws);
    }];
    
    [historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2.mas_right);
        make.top.bottom.equalTo(rankingBtn);
        make.width.equalTo(liveBtn);
    }];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(historyBtn.mas_right);
        make.size.equalTo(lineView1);
        make.centerY.equalTo(ws);
    }];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView3.mas_right);
        make.top.bottom.equalTo(rankingBtn);
        make.width.equalTo(historyBtn);
        make.right.equalTo(ws);
    }];
    
    
}
- (UIButton *)_customBtnViewWithTitle:(NSString *)title image:(NSString *)image flag:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = flag;
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    [btn addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn).with.offset(14);
        make.centerX.equalTo(btn);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:title font:10 textColor:ColorHexadecimal(0x9b9b9b, 1.0) textAlignment:1 backgroundColor:nil];
    [btn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).with.offset(4);
        make.centerX.equalTo(btn);
    }];
    [btn addTarget:self action:@selector(funcClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)funcClick:(UIButton *)btn {
    if (self.funcBlock) {
        self.funcBlock(btn.tag - 200);
    }
}
@end
