//
//  LCMySpaceTabView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCMySpaceTabView.h"

@implementation LCMySpaceTabView
{
    UIView *_lineView;
    NSInteger _currentSelect;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)buttonClick:(UIButton *)btn {
    if (!btn.selected) {
        UIButton *otherBtn = [self viewWithTag:200 + _currentSelect];
        if (otherBtn) {
            otherBtn.selected = NO;
        }
        _currentSelect = btn.tag - 200;
        btn.selected = YES;
        CGRect frame = _lineView.frame;
        CGFloat x = CGRectGetMinX(btn.frame);
        frame.origin.x = x;
        _lineView.frame = frame;
        if (self.tabbarBlock) {
            self.tabbarBlock(_currentSelect);
        }
    }
}
- (void)_layoutMainView {
    _currentSelect = 0;
    UIButton *leftBtn = [LSKViewFactory initializeButtonWithTitle:@"帖子" target:self action:@selector(buttonClick:) textfont:15 textColor:ColorHexadecimal(0x7d7d7d, 1.0)];
    leftBtn.tag = 200;
    [leftBtn setTitleColor:ColorHexadecimal(0xff0000, 1.0) forState:UIControlStateSelected];
    leftBtn.selected = YES;
    [self addSubview:leftBtn];
    
    UIButton *middleBtn = [LSKViewFactory initializeButtonWithTitle:@"擂台贴" target:self action:@selector(buttonClick:) textfont:15 textColor:ColorHexadecimal(0x7d7d7d, 1.0)];
    middleBtn.tag = 201;
    [middleBtn setTitleColor:ColorHexadecimal(0xff0000, 1.0) forState:UIControlStateSelected];
    [self addSubview:middleBtn];
    
    UIButton *rightBtn = [LSKViewFactory initializeButtonWithTitle:@"打赏" target:self action:@selector(buttonClick:) textfont:15 textColor:ColorHexadecimal(0x7d7d7d, 1.0)];
    rightBtn.tag = 202;
    [rightBtn setTitleColor:ColorHexadecimal(0xff0000, 1.0) forState:UIControlStateSelected];
    [self addSubview:rightBtn];
    WS(ws)
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws);
        make.bottom.equalTo(ws).with.offset(-2);
    }];
    [middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right);
        make.top.bottom.width.equalTo(leftBtn);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleBtn.mas_right);
        make.top.bottom.width.equalTo(middleBtn);
        make.right.equalTo(ws);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(0xff0000, 1.0);
    _lineView = lineView;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(leftBtn);
        make.bottom.equalTo(ws);
        make.height.mas_equalTo(2);
    }];
    
    
}

@end
