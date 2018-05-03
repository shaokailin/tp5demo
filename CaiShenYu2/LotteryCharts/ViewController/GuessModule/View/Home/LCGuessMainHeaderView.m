//
//  LCGuessMainHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainHeaderView.h"

@implementation LCGuessMainHeaderView
{
    UILabel *_timeLbl;
    UILabel *_countLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTime:(NSString *)time count:(NSString *)count {
    _timeLbl.text = time;
    _countLbl.text = count;
}
- (void)_layoutMainView {
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    UILabel *timeLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:ColorHexadecimal(0x7d7d7d, 1.0) textAlignment:0 backgroundColor:nil];
    _timeLbl = timeLbl;
    [contentView addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(15);
        make.centerY.equalTo(contentView);
    }];
    
    UILabel *countLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:[UIColor redColor] textAlignment:0 backgroundColor:nil];
    _countLbl = countLbl;
    [contentView addSubview:countLbl];
    [countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLbl.mas_right).with.offset(15);
        make.centerY.equalTo(contentView);
    }];
    
    UIButton *moreBtn = [LSKViewFactory initializeButtonWithTitle:@"更多" nornalImage:@"home_arrow1" selectedImage:@"home_arrow1" target:self action:@selector(moreClick) textfont:10 textColor:ColorHexadecimal(0x898989, 1.0) backgroundColor:nil backgroundImage:nil];
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9);
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -21);
    [contentView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.right.equalTo(contentView).with.offset(-10);
        make.width.mas_equalTo(50);
    }];
    [self addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
}
- (void)moreClick {
    if (self.moreBlock) {
        self.moreBlock(self.tag);
    }
}
@end
