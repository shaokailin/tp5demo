//
//  PPSSPiskSelectView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPiskSelectView.h"
static const NSInteger kContentViewHeight = 254;
@implementation PPSSPiskSelectView
{
    BOOL _isShow;
    UIView *_bgView;
    PPSSPickView *_pickView;
    UIView *_contentView;
    UILabel *_titleLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeMainView];
    }
    return self;
}
- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLbl.text = _titleText;
}
- (void)setPickViewSource:(NSArray *)array {
    [_pickView setPickViewSource:array];
}
#pragma mark -view
- (void)initializeMainView {
    self.hidden = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *cancleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleSelectedClick)];
    [bgView addGestureRecognizer:cancleTap];
    bgView.alpha = 0;
    _bgView = bgView;
    [self addSubview:bgView];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), SCREEN_WIDTH, kContentViewHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:13 textColor:ColorHexadecimal(Color_Text_3333, 1.0) textAlignment:0 backgroundColor:nil];
    _titleLbl.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 44);
    [headView addSubview:_titleLbl];
    [_contentView addSubview:headView];
    _pickView = [[PPSSPickView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 165)];
    [contentView addSubview:_pickView];
    [self _latoutUnderButtonView];
}
- (void)_latoutUnderButtonView {
    UIView *underBtnView = [[UIView alloc]init];
    underBtnView.backgroundColor = COLOR_WHITECOLOR;
    underBtnView.frame = CGRectMake(0, 165 + 44, SCREEN_WIDTH, 45);
    [_contentView addSubview:underBtnView];
    
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [underBtnView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(underBtnView);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    UIButton *cancleBtn = [LSKViewFactory initializeButtonWithTitle:@"取消" nornalImage:nil selectedImage:nil target:self action:@selector(cancleSelectedClick) textfont:15 textColor:ColorHexadecimal(Color_Text_6666, 1.0) backgroundColor:nil backgroundImage:nil];
    [underBtnView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(underBtnView);
        make.right.equalTo(underBtnView.mas_centerX);
        make.top.equalTo(lineView.mas_bottom);
    }];
    
    UIButton *sureBtn = [LSKViewFactory initializeButtonWithTitle:@"确定" nornalImage:nil selectedImage:nil target:self action:@selector(sureSelectClick) textfont:15 textColor:COLOR_WHITECOLOR backgroundColor:ColorHexadecimal(Color_APP_MAIN, 1.0) backgroundImage:nil];
    [underBtnView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(underBtnView);
        make.left.equalTo(underBtnView.mas_centerX);
    }];
}
- (void)showInView {
    if (!_isShow) {
        self.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _bgView.alpha = 1;
            _contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - kContentViewHeight , SCREEN_WIDTH, kContentViewHeight);
        }];
    }
}
- (void)setType:(PickViewType)type {
    if (_type != type) {
        _type = type;
        _pickView.pickViewType = type;
    }
}
- (void)sureSelectClick {
    if (self.pickBlock) {
        self.pickBlock(_type, [_pickView returnCurrentSelectString]);
    }
    [self cancleSelectedClick];
}
- (void)cancleSelectedClick {
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0;
        _contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) , SCREEN_WIDTH, kContentViewHeight);
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
@end
