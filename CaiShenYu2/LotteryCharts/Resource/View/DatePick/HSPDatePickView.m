//
//  HSPDatePickView.m
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "HSPDatePickView.h"

@implementation HSPDatePickView
{
    UIDatePicker *_datePick;
    UILabel *_titleLabel;
    UIView *_contentView;
    BOOL isShow;
    UIView *_bgView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeMainView];
    }
    return self;
}
- (void)initializeMainView {
    self.hidden = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *cancleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleSelectedClick)];
    [bgView addGestureRecognizer:cancleTap];
    bgView.alpha = 0;
    _bgView = bgView;
    [self addSubview:bgView];
    _datePickerMode = UIDatePickerModeDate;
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), SCREEN_WIDTH, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    UIDatePicker *datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
//    datePick.backgroundColor = [UIColor yellowColor];
    [datePick setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePick setTimeZone:[NSTimeZone localTimeZone]];
    datePick.minuteInterval = 5;
    [datePick setDatePickerMode:_datePickerMode];
    _datePick = datePick;
    [_contentView addSubview:datePick];
    [self initializeNaviButtonView];
}

- (void)initializeNaviButtonView {
    UIButton *naviView = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:nil action:nil textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
    naviView.frame = CGRectMake(0, 160, SCREEN_WIDTH, 40);
    [_contentView addSubview:naviView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(kLineMain_Color, 1.0);
    [naviView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(naviView);
        make.height.mas_equalTo(kLineView_Height);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = ColorHexadecimal(kLineMain_Color, 1.0);
    [naviView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(naviView);
        make.centerX.equalTo(naviView);
        make.width.mas_equalTo(kLineView_Height);
    }];
    
    UIButton *cancleBtn = [LSKViewFactory initializeButtonWithTitle:@"取消" nornalImage:nil selectedImage:nil target:self action:@selector(cancleSelectedClick) textfont:15 textColor:ColorHexadecimal(0x333333, 1.0) backgroundColor:nil backgroundImage:nil];
    [naviView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(naviView);
        make.right.equalTo(lineView1.mas_left);
    }];
    
    UIButton *sureBtn = [LSKViewFactory initializeButtonWithTitle:@"确定" nornalImage:nil selectedImage:nil target:self action:@selector(sureSelectClick) textfont:15 textColor:ColorHexadecimal(0x333333, 1.0) backgroundColor:nil backgroundImage:nil];
    [naviView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(naviView);
        make.size.equalTo(cancleBtn);
    }];
}
- (void)showInView {
    if (!isShow) {
        self.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self->_bgView.alpha = 1;
            self->_contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 200 , SCREEN_WIDTH, 200);
        }];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    _datePickerMode = datePickerMode;
    _datePick.datePickerMode = datePickerMode;
}
- (void)setMinDate:(NSDate *)minDate {
    _minDate = minDate;
    _datePick.minimumDate = minDate;
}
- (void)setMaxDate:(NSDate *)maxDate {
    _maxDate = maxDate;
    _datePick.maximumDate = maxDate;
}
- (void)sureSelectClick {
    if (self.dateBlock) {
        self.dateBlock(_datePick.date);
    }
    [self cancleSelectedClick];
}
- (void)cancleSelectedClick {
    [UIView animateWithDuration:0.25 animations:^{
        self->_bgView.alpha = 0;
        self->_contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) , SCREEN_WIDTH, 200);
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
@end
