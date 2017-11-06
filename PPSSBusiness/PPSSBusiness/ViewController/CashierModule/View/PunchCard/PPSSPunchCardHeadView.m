//
//  PPSSPunchCardHeadView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/11/4.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPunchCardHeadView.h"
@interface PPSSPunchCardHeadView ()
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UILabel *weekLbl;
@property (nonatomic, weak) UILabel *yearLbl;
@property (nonatomic, weak) UILabel *liningLbl;
@property (nonatomic, weak) UIButton *outLineBtn;
@property (nonatomic, strong) NSCalendar *calendar;
@end
@implementation PPSSPunchCardHeadView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UILabel *timeLble = [LSKViewFactory initializeLableWithText:nil font:53 textColor:ColorHexadecimal(0xccffff, 1.0) textAlignment:1 backgroundColor:nil];
    self.timeLbl = timeLble;
    [self addSubview:timeLble];
    WS(ws)
    [timeLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(24);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *lineLbl = [LSKViewFactory initializeLableWithText:@"                                 " font:12 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    self.liningLbl = lineLbl;
    [self addSubview:lineLbl];
    [lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).with.offset(-22 - 5.5);
        make.left.greaterThanOrEqualTo(ws).with.offset(75);
        make.right.lessThanOrEqualTo(ws).with.offset(-82);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *lineTitleLbl = [LSKViewFactory initializeLableWithText:@"当前在线：" font:0 textColor:COLOR_WHITECOLOR textAlignment:0 backgroundColor:nil];
    lineTitleLbl.font = FontBoldInit(12);
    [self addSubview:lineTitleLbl];
    [lineTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineLbl.mas_left);
        make.centerY.equalTo(lineLbl);
    }];
    
    UIImageView *dotImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"record_dot")];
    [self addSubview:dotImageView];
    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.bottom.equalTo(ws);
        make.height.mas_equalTo(11);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_WHITECOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(11/2.0);
    }];
    
    UIView *circleView = [[UIView alloc]init];
    ViewRadius(circleView, 5 / 2.0);
    circleView.backgroundColor = COLOR_WHITECOLOR;
    [self addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 5));
        make.bottom.equalTo(lineLbl.mas_top).with.offset(-25);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *weekLbl = [LSKViewFactory initializeLableWithText:nil font:18 textColor:ColorHexadecimal(0xccffff, 1.0) textAlignment:0 backgroundColor:nil];
    self.weekLbl = weekLbl;
    [self addSubview:weekLbl];
    [weekLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(circleView.mas_left).with.offset(-9);
        make.centerY.equalTo(circleView);
    }];
    
    UILabel *yearLble = [LSKViewFactory initializeLableWithText:nil font:21 textColor:ColorHexadecimal(0xccffff, 1.0) textAlignment:0 backgroundColor:nil];
    self.yearLbl = yearLble;
    [self addSubview:yearLble];
    [yearLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).with.offset(9);
        make.centerY.equalTo(circleView);
    }];
    [self updateTimeEvent];
}
- (void)updateTimeEvent {
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    self.yearLbl.text = NSStringFormat(@"%zd",comps.year);
    self.timeLbl.text = NSStringFormat(@"%@:%@",[self returnTime:comps.hour],[self returnTime:comps.minute]);
    self.weekLbl.text = [self weekText:comps.weekday];
}
- (NSString *)returnTime:(NSInteger)time {
    if (time < 10) {
        return NSStringFormat(@"0%zd",time);
    }else {
        return NSStringFormat(@"%zd",time);
    }
}
- (NSString *)weekText:(NSInteger)week {
    NSString *weekString = nil;
    switch (week) {
        case 1:
            weekString = @"星期日";
            break;
        case 2:
            weekString = @"星期一";
            break;
        case 3:
            weekString = @"星期二";
            break;
        case 4:
            weekString = @"星期三";
            break;
        case 5:
            weekString = @"星期四";
            break;
        case 6:
            weekString = @"星期五";
            break;
        case 7:
            weekString = @"星期六";
            break;
        default:
            break;
    }
    return weekString;
}
- (void)offLineCashierClick {
    if (self.cashierBlock) {
        self.cashierBlock(1);
    }
}
- (void)setupLineNameWithTime:(NSString *)timeString name:(NSString *)name {
    if (KJudgeIsNullData(name)) {
        self.liningLbl.text = NSStringFormat(@"%@:  %@",name,timeString);
        self.outLineBtn.hidden = NO;
    }else {
        self.liningLbl.text = @"                                 ";
        self.outLineBtn.hidden = YES;
    }
}
- (UIButton *)outLineBtn {
    if (!_outLineBtn) {
        WS(ws)
        UIButton *outLineBtn = [LSKViewFactory initializeButtonWithTitle:@"踢下线" nornalImage:nil selectedImage:nil target:self action:@selector(offLineCashierClick) textfont:12 textColor:ColorHexadecimal(Color_APP_MAIN, 1.0) backgroundColor:ColorHexadecimal(0xfede2d, 1.0) backgroundImage:nil];
        ViewRadius(outLineBtn, 10);
        _outLineBtn = outLineBtn;
        [self addSubview:outLineBtn];
        [outLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.liningLbl.mas_right).with.offset(12);
            make.centerY.equalTo(ws.liningLbl);
            make.size.mas_equalTo(CGSizeMake(55, 20));
        }];
    }
    return _outLineBtn;
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
@end
