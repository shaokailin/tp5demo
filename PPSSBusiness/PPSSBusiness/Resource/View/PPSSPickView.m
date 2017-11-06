//
//  PPSSPickView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPickView.h"
#import "PPSSShopListModel.h"
static NSString * const kDatePlistName = @"DateTime";
static NSString * const kMinuteKeyName = @"minute";
static NSString * const kHourKeyName = @"hour";
static const NSInteger kMinYear = 2012;
static const NSInteger kMaxYearBetween = 10;
@interface PPSSPickView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger _maxOneCol;
    NSInteger _maxTwoCol;
    NSInteger _maxThreeCol;
    NSInteger _selectOneRow;
    NSInteger _selectTwoRow;
    NSInteger _selectThreeRow;
    NSInteger _selectFourRow;
    NSInteger _selectFiveRow;
    
    NSInteger _maxYear;
    NSInteger _maxMonth;
    NSInteger _maxDay;
    NSInteger _minYear;
    NSInteger _minMonth;
    NSInteger _minDay;

    
    NSDictionary *_dateTimeDic;
    UIColor *_lineColor;
}
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, weak) UIPickerView *pickView;
@end
@implementation PPSSPickView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _pickViewType = PickViewType_Date;
        [self _setupView];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 165);
        _pickViewType = PickViewType_Date;
        [self _setupView];
    }
    return self;
}
- (void)setPickViewType:(PickViewType)pickViewType {
    if (_pickViewType != pickViewType) {
        _pickViewType = pickViewType;
        if (pickViewType == PickViewType_Activity) {
            _maxOneCol = 9;
            _selectOneRow = 0;
        }else if (pickViewType == PickViewType_Discount){
            _maxOneCol = 101;
            _selectOneRow = 0;
        }else if (pickViewType != PickViewType_Source) {
            _maxOneCol = _maxYear - _minYear + 1;
            if (_selectOneRow == 0 || _selectOneRow == _maxOneCol) {
                [self calcuteCurrentYear];
            }else {
                _maxTwoCol = 12;
                if (_selectTwoRow >= _maxTwoCol) {
                    _selectOneRow = 0;
                    [self.pickView selectRow:_selectTwoRow inComponent:1 animated:NO];
                }
                _maxThreeCol = [NSDate getDaysInYear:_selectOneRow + _minYear month:_selectTwoRow + 1];
            }
        }else {
            _maxOneCol = self.sourceArray.count;
            _selectOneRow = 0;
        }
        [self.pickView reloadAllComponents];
        [self changeCurrentSelect];
    }
}
#pragma mark public
- (NSString *)returnCurrentSelectString {
    if (_pickViewType == PickViewType_DateAndTime) {
        return NSStringFormat(@"%@-%@-%@ %@%@",[self returnTitleWithRow:_selectOneRow component:0],[self returnTitleWithRow:_selectTwoRow component:1],[self returnTitleWithRow:_selectThreeRow component:2] ,[self returnTitleWithRow:_selectFourRow component:3],[self returnTitleWithRow:_selectFiveRow component:4]);
    }else if (_pickViewType == PickViewType_Source) {
        return NSStringFormat(@"%ld",(long)_selectOneRow);
    }else if (_pickViewType == PickViewType_Time) {
        return NSStringFormat(@"%@:%@",[self returnTitleWithRow:_selectOneRow component:0],[self returnTitleWithRow:_selectTwoRow component:1]);
    }else if (_pickViewType == PickViewType_Activity){
        return NSStringFormat(@"%zd",(_selectOneRow + 1) * 5);
    }else if (_pickViewType == PickViewType_Discount){
        return NSStringFormat(@"%ld",(long)_selectOneRow);
    }
    else {
        return NSStringFormat(@"%@-%@-%@",[self returnTitleWithRow:_selectOneRow component:0],[self returnTitleWithRow:_selectTwoRow component:1],[self returnTitleWithRow:_selectThreeRow component:2]);
    }
}
- (void)setPickViewSource:(NSArray *)array {
    if (array && array.count > 0) {
        if (self.sourceArray.count > 1) {
            [self.sourceArray removeObjectsInRange:NSMakeRange(1, self.sourceArray.count - 1)];
        }
        [self.sourceArray addObjectsFromArray:array];
    }
    [self.pickView reloadAllComponents];
    _selectOneRow = 0;
    [self changeCurrentSelect];
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray arrayWithObject:@"全部门店"];
        _selectOneRow = 0;
    }
    return _sourceArray;
}
#pragma mark -界面初始化
- (void)_setupView {
    [self _setupDataSource];
    [self _layoutMainView];
}
- (void)_setupDataSource {
    _minDay = 1;
    _minYear = kMinYear;
    _minMonth = 1;
    [self getCurrentDate];
    _lineColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    if (_pickViewType != PickViewType_Source && _pickViewType != PickViewType_Activity && _pickViewType != PickViewType_Discount) {
        _dateTimeDic = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:kDatePlistName ofType:@"plist"]];
        
        _selectFiveRow = 0;
        _selectFourRow = 0;
        _maxOneCol = _maxYear - _minYear + 1;
        _selectOneRow = _maxOneCol - 1;
        _maxTwoCol = _maxMonth - _minMonth + 1;
        _selectTwoRow = _maxTwoCol - 1;
        _maxThreeCol = _maxDay - _minDay + 1;
        _selectThreeRow = _maxThreeCol - 1;
    }else {
        _selectThreeRow = 0;
        _selectTwoRow = 0;
        _selectOneRow = 0;
        _selectFiveRow = 0;
        _selectFourRow = 0;
    }
}

- (void)_layoutMainView {
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:self.bounds];
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.showsSelectionIndicator = YES;
    self.pickView = pickView;
    [self addSubview:pickView];
    [self.pickView selectRow:_selectOneRow inComponent:0 animated:NO];
    [self.pickView selectRow:_selectTwoRow inComponent:1 animated:NO];
    [self.pickView selectRow:_selectThreeRow inComponent:2 animated:NO];
}
//设置一大最大的日期
- (void)setMaxDate:(NSDate *)maxDate {
    _maxDate = maxDate;
    if (maxDate) {
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:maxDate];
        _maxYear = comps.year;
        _maxMonth = comps.month;
        _maxDay = comps.day;
    }
     [self calcuteCurrentYear];
    _selectOneRow = _maxOneCol - 1;
    _selectTwoRow = _maxTwoCol - 1;
    _selectThreeRow = _maxThreeCol - 1;
    [self.pickView selectRow:_selectOneRow inComponent:0 animated:YES];
    [self.pickView selectRow:_selectTwoRow inComponent:1 animated:YES];
    [self.pickView selectRow:_selectThreeRow inComponent:2 animated:YES];
}
- (void)setMinDate:(NSDate *)minDate {
    _minDate = minDate;
    if (minDate) {
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:minDate];
        _minYear = comps.year;
        _minMonth = comps.month;
        _minDay = comps.day;
    }
    [self calcuteCurrentYear];
    _selectOneRow = 0;
    _selectTwoRow = 0;
    _selectThreeRow = 0;
    [self.pickView selectRow:_selectOneRow inComponent:0 animated:YES];
    [self.pickView selectRow:_selectTwoRow inComponent:1 animated:YES];
    [self.pickView selectRow:_selectThreeRow inComponent:2 animated:YES];
}
- (void)calcuteCurrentYear {
    if (_maxDate == nil) {
        _maxYear = _minYear + kMaxYearBetween;
        _maxMonth = 12;
        _maxDay = [NSDate getDaysInYear:_maxYear month:_maxMonth];
    }else if (_minDate == nil) {
        _minYear = kMinYear;
        _minMonth = 1;
        _minDay = 1;
    }
    _maxOneCol = _maxYear - _minYear + 1;
    _maxTwoCol = _maxMonth - _minMonth + 1;
    _maxThreeCol = _maxDay - _minDay + 1;
    [self.pickView reloadAllComponents];
}

//设置一个最大的范围日期
- (void)getCurrentDate {
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    _maxDay = comps.day;
    _maxYear = comps.year;
    _maxMonth = comps.month;
}
//当修改列表的时候，当前选中的时候超出范围的时候优化
- (void)changeCurrentSelect {
    if (_selectOneRow > _maxOneCol - 1) {
        _selectOneRow = _maxOneCol - 1;
    }
    [self.pickView selectRow:_selectOneRow inComponent:0 animated:NO];
    if (_pickViewType == PickViewType_Source || _pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount) {
        return;
    }
    if (_selectTwoRow > _maxTwoCol - 1) {
        _selectTwoRow = _maxTwoCol - 1;
    }
    [self.pickView selectRow:_selectTwoRow inComponent:1 animated:NO];
    if (_pickViewType == PickViewType_Time) {
        return;
    }
    if (_selectThreeRow > _maxThreeCol - 1) {
        _selectThreeRow = _maxThreeCol - 1;
    }
    [self.pickView selectRow:_selectThreeRow inComponent:2 animated:NO];
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
#pragma mark - delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source || _pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount) {
        return SCREEN_WIDTH;
    }else if (_pickViewType == PickViewType_Date) {
        return SCREEN_WIDTH / 3.0;
    }else if (_pickViewType == PickViewType_Time) {
        return SCREEN_WIDTH / 2.0;
    }else {
        if (component < 3) {
            if (component == 0) {
                return SCREEN_WIDTH / 4.0;
            }else {
                return SCREEN_WIDTH / 5.0;
            }
        }else {
            return (SCREEN_WIDTH - SCREEN_WIDTH * 2 / 5.0 - SCREEN_WIDTH / 4.0) / 2.0;
        }
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_pickViewType == PickViewType_Source || _pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount) {
        return 1;
    }else if (_pickViewType == PickViewType_Date) {
        return 3;
    }else if(_pickViewType == PickViewType_Time){
        return 2;
    } else{
        return 5;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source) {
        return _sourceArray == nil ? 1 : _sourceArray.count;
    }else if (_pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount){
        return _maxOneCol;
    }
    else if (_pickViewType == PickViewType_Time) {
        if (component == 0) {
            return 24;
        }else {
            return 60;
        }
    }else {
        if (component == 0) {
            return _maxOneCol;
        }else if (component == 1) {
            return _maxTwoCol;
        }else if(component == 2) {
            return _maxThreeCol;
        }else if (component == 3) {
            return 24;
        }else {
            return 60;
        }
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = _lineColor;
        }
    }
    if (_pickViewType == PickViewType_Source || _pickViewType == PickViewType_Time || _pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount) {
        if (view && [view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
        if (!view) {
            view = [[UIView alloc]init];
        }
        UILabel  *pickerLabel = [view viewWithTag:201];
        if (pickerLabel == nil) {
            pickerLabel = [[UILabel alloc]init];
            pickerLabel.tag = 201;
            pickerLabel.font = FontNornalInit(16);
            pickerLabel.textAlignment = 0;
            CGFloat width = SCREEN_WIDTH - 42;
            if (_pickViewType == PickViewType_Time) {
                width = SCREEN_WIDTH / 2.0 - 42;
                if (component == 1) {
                    pickerLabel.textAlignment = 2;
                    width -= 42;
                }
            }
            pickerLabel.frame = CGRectMake(42, 0, width, 27);
            [view addSubview:pickerLabel];
        }
        if (_pickViewType == PickViewType_Time) {
            pickerLabel.text = [self returnTitleWithRow:row component:component];
        }else if (_pickViewType == PickViewType_Activity) {
            pickerLabel.text = NSStringFormat(@"%zd%%",(row + 1) * 5);
        }else if (_pickViewType == PickViewType_Discount){
            pickerLabel.text = NSStringFormat(@"%ld%%",(long)row);
        }else {
            if (row == 0) {
                pickerLabel.text = @"全部门店";
            }else {
                PPSSShopModel *model = [self.sourceArray objectAtIndex:row];
                pickerLabel.text = model.shopName;
            }
        }
        return view;
    }else {
        UILabel* pickerLabel = (UILabel*)view;
        if (!pickerLabel) {
            pickerLabel = [[UILabel alloc]init];
            pickerLabel.font = FontNornalInit(12);
        }
        if (component == 3) {
            pickerLabel.textAlignment = 2;
        }else if (component == 4) {
            pickerLabel.textAlignment = 0;
        }else {
            pickerLabel.textAlignment = 1;
        }
        pickerLabel.text = [self returnTitleWithRow:row component:component];
        return pickerLabel;
    }
}
- (NSString *)returnTitleWithRow:(NSInteger)row component:(NSInteger)component {
    NSString *title = nil;
    if (component == 0 && _pickViewType != PickViewType_Time) {
        title = NSStringFormat(@"%zd",row + _minYear);
    }else if(_pickViewType == PickViewType_Time){
        NSArray *array = [_dateTimeDic objectForKey:kMinuteKeyName];
        title = [array objectAtIndex:row];
    }else if(component > 2) {
        NSString *key = component == 3?kHourKeyName:kMinuteKeyName;
        NSArray *array = [_dateTimeDic objectForKey:key];
        title = [array objectAtIndex:row];
    }else {
        NSArray *array = [_dateTimeDic objectForKey:kMinuteKeyName];
        NSInteger index = row + 1;
        if (component == 1 && _selectOneRow == 0) {
            index = row + _minMonth;
        }
        if (component == 2 && _selectOneRow == 0 && _selectTwoRow == 0) {
            index = row + _minDay;
        }
        title = [array objectAtIndex:index];
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source || _pickViewType == PickViewType_Activity || _pickViewType == PickViewType_Discount) {
        _selectOneRow = row;
    }else if (_pickViewType == PickViewType_Time){
        if (component == 0) {
            _selectOneRow = row;
        }else {
            _selectTwoRow = row;
        }
    }else {
        if (component < 3) {
            BOOL change = NO;
            if (component == 0) {
                if (_selectOneRow != row) {
                    _selectOneRow = row;
                    change = YES;
                }
            }else if (component == 1) {
                if (_selectTwoRow != row) {
                    _selectTwoRow = row;
                    change = YES;
                }
            }else if(component == 2) {
                if (_selectThreeRow != row) {
                    _selectThreeRow = row;
                    change = YES;
                }
            }
            if (change) {
                [self changeRowMaxWithIndex:component];
            }
        }else {
            if (component == 3) {
                _selectFourRow = row;
            }else {
                _selectFiveRow = row;
            }
        }
    }
    
}
- (void)changeRowMaxWithIndex:(NSInteger)component {
    if (component == 0) {
        NSInteger maxTwo = 12;
        if (_selectOneRow == 0) {
            maxTwo = maxTwo - _minMonth + 1;
        }else if (_selectOneRow == _maxOneCol - 1) {
            maxTwo = _maxMonth;
        }
        if (_maxTwoCol != maxTwo) {
            _maxTwoCol = maxTwo;
            [self.pickView reloadComponent:1];
            if (_selectTwoRow > _maxTwoCol - 1) {
                _selectTwoRow = _maxTwoCol - 1;
                [self.pickView selectRow:_selectTwoRow inComponent:1 animated:YES];
            }
        }
        [self changeDayMax];
    }else if (component == 1){
        [self changeDayMax];
    }
}
- (void)changeDayMax {
    NSInteger maxDay = 0;
    if (_selectOneRow == _maxOneCol - 1 && _selectTwoRow == _maxTwoCol - 1) {
        maxDay = _maxDay;
    }else {
        NSInteger selectTwo = _selectOneRow == 0?_selectTwoRow + _minMonth:_selectTwoRow + 1;
        maxDay = [NSDate getDaysInYear:_selectOneRow + _minYear month:selectTwo];
        if (_selectOneRow == 0 && _selectTwoRow == 0) {
            maxDay = maxDay - _minDay + 1;
        }
    }
    if (_maxThreeCol != maxDay) {
        _maxThreeCol = maxDay;
        [self.pickView reloadComponent:2];
        if (_selectThreeRow > _maxThreeCol - 1) {
            _selectThreeRow = _maxThreeCol - 1;
            [self.pickView selectRow:_selectThreeRow inComponent:2 animated:YES];
        }
    }
}
@end
