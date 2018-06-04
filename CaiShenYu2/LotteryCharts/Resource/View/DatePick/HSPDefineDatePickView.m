//
//  HSPDefineDatePickView.m
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/24.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "HSPDefineDatePickView.h"
@interface HSPDefineDatePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_datePick;
    UIView *_contentView;
    BOOL isShow;
    UIView *_bgView;
    NSInteger _rowSelect;
    NSInteger _selectYear;
    NSInteger _currentYear;
    NSInteger _currentMonth;
   
}
@property (nonatomic, strong) NSArray *mouthArray;
@property (nonatomic, strong)  NSCalendar *calendar;
@end
static const NSInteger kMinStartYear = 2000;

@implementation HSPDefineDatePickView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeMainView];
    }
    return self;
}
#pragma mark -view
- (void)initializeMainView {
    [self getCurrentDate:YES];
    self.hidden = YES;
    _rowSelect = 0;
    _selectYear = 0;
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *cancleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleSelectedClick)];
    [bgView addGestureRecognizer:cancleTap];
    bgView.alpha = 0;
    _bgView = bgView;
    [self addSubview:bgView];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), SCREEN_WIDTH, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    UIPickerView *datePick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    datePick.delegate = self;
    datePick.dataSource = self;
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
        [self getCurrentDate:NO];
        self.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self->_bgView.alpha = 1;
            self->_contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 200 , SCREEN_WIDTH, 200);
        }];
    }
}

- (void)sureSelectClick {
    if (self.dateBlock) {
        if (self.datePickerMode == 0) {
            self.dateBlock(kMinStartYear + _rowSelect);
        }else {
            self.dateBlock(_rowSelect + 1);
        }
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
- (void)setDatePickerMode:(DefineDateType)datePickerMode {
    if (_datePickerMode != datePickerMode) {
        _datePickerMode = datePickerMode;
        if (_rowSelect != 0) {
            [_datePick selectRow:0 inComponent:0 animated:NO];
        }
        _rowSelect = 0;
        [_datePick reloadAllComponents];
    }
}
#pragma mark - delegate 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.datePickerMode == 0) {
        return _currentYear - kMinStartYear + 1;;
    }else {
        if (_currentYear == _selectYear + kMinStartYear) {
            return _currentMonth;
        }
        return 12;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _rowSelect = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    static BOOL isHas = NO;
    if (!isHas) {
        isHas = YES;
        for(UIView *singleLine in pickerView.subviews)
        {
            if (singleLine.frame.size.height < 1)
            {
                singleLine.backgroundColor = ColorHexadecimal(0xd0d0d0, 1.0);
            }
        }
    }
    NSString *string = nil;
    if (self.datePickerMode == 0) {
        string = [NSString stringWithFormat:@"%d年",row + kMinStartYear];
    }else {
        string = [NSString stringWithFormat:@"%d月",row + 1];
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = string;
    genderLabel.textColor = ColorHexadecimal(0x282828, 1.0);
    genderLabel.font = FontNornalInit(15);
    
    return genderLabel;
}
#pragma mark 日期事件
- (NSArray *)mouthArray {
    if (!_mouthArray) {
        _mouthArray = [NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    }
    return _mouthArray;
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
- (void)getCurrentDate:(BOOL)isFirst {
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    BOOL isNeedReoad = !isFirst && (_currentYear != comps.year || _currentMonth != comps.month) ? YES : NO;
    _currentYear = comps.year;
    _currentMonth = comps.month;
    if (isNeedReoad) {
        [_datePick reloadAllComponents];
    }
}
- (void)setupSelectYear:(NSInteger)year {
    _selectYear = year - kMinStartYear;
}
@end
