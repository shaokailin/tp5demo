//
//  LCTeamHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamHeaderView.h"

@implementation LCTeamHeaderView
{
    UILabel *_countLineLbl;
    UILabel *_allCountLbl;
    NSInteger _currentType;
    UIView *_lineView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(0x66a9f7, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)buttonClick:(UIButton *)btn {
    if (!btn.selected) {
        UIButton *otherBtn = [self viewWithTag:200 + _currentType];
        if (otherBtn) {
            otherBtn.selected = NO;
        }
        _currentType = btn.tag - 200;
        btn.selected = YES;
        CGRect frame = _lineView.frame;
        CGFloat x = CGRectGetMinX(btn.frame);
        frame.origin.x = x;
        _lineView.frame = frame;
        if (self.teamBlock) {
            self.teamBlock(_currentType);
        }
    }
}
- (void)setupContentWithLineCount:(NSString *)line allCount:(NSString *)allCount {
    if (_currentType == 0) {
        _allCountLbl.text = NSStringFormat(@"团员: %@人",allCount);
        _countLineLbl.text = NSStringFormat(@"%@人在线",line);
    }else {
        _allCountLbl.text = NSStringFormat(@"%@人已签到",allCount);
        _countLineLbl.text = NSStringFormat(@"您已获取%@银币",line);
    }
}
- (void)_layoutMainView {
    _currentType = 0;
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = ColorHexadecimal(0xbfbfbf, 1.0);
    [bottomView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bottomView);
        make.height.mas_equalTo(2);
    }];
    
    UIButton *leftBtn = [LSKViewFactory initializeButtonWithTitle:@"团队" target:self action:@selector(buttonClick:) textfont:15 textColor:ColorHexadecimal(0xbfbfbf, 1.0)];
    leftBtn.tag = 200;
    [leftBtn setTitleColor:ColorHexadecimal(0x66a9f7, 1.0) forState:UIControlStateSelected];
    leftBtn.selected = YES;
    [bottomView addSubview:leftBtn];
    
    UIButton *rightBtn = [LSKViewFactory initializeButtonWithTitle:@"签到" target:self action:@selector(buttonClick:) textfont:15 textColor:ColorHexadecimal(0xbfbfbf, 1.0)];
    rightBtn.tag = 201;
    [rightBtn setTitleColor:ColorHexadecimal(0x66a9f7, 1.0) forState:UIControlStateSelected];
    [bottomView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bottomView);
        make.bottom.equalTo(lineView1.mas_top);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right);
        make.top.bottom.width.equalTo(leftBtn);
        make.right.equalTo(bottomView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(0x66a9f7, 1.0);
    _lineView = lineView;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(leftBtn);
        make.bottom.equalTo(bottomView);
        make.height.mas_equalTo(2);
    }];
    [self addSubview:bottomView];
    WS(ws)
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(ws);
        make.height.mas_equalTo(42);
    }];
    UILabel *countLineLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:ColorHexadecimal(0xffffff, 0.5) textAlignment:1 backgroundColor:nil];
    _countLineLbl = countLineLbl;
    [self addSubview:countLineLbl];
    
    [countLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top).with.offset(-40);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *allCountLbl = [LSKViewFactory initializeLableWithText:nil font:20 textColor:ColorHexadecimal(0xffffff,1.0) textAlignment:0 backgroundColor:nil];
    _allCountLbl = allCountLbl;
    [self addSubview:allCountLbl];
    [allCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(countLineLbl.mas_top).with.offset(-15);
        make.centerX.equalTo(ws);
    }];
    [self setupContentWithLineCount:@"0" allCount:@"0"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
