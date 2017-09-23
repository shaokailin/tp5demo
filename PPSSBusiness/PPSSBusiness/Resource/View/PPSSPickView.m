//
//  PPSSPickView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPickView.h"
static NSString * const kDatePlistName = @"DateTime";
static NSString * const kMinuteKeyName = @"minute";
static NSString * const kHourKeyName = @"hour";
static NSInteger kMinYear = 2012;
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
    
    
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
    
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
        if (_pickViewType == PickViewType_Source) {
            _maxOneCol = _currentYear - kMinYear;
            [self changeCurrentSelect];
        }else {
            _maxOneCol = self.sourceArray.count;
            [self changeSourceSelect];
        }
        _pickViewType = pickViewType;
        [self.pickView reloadAllComponents];
    }
}
#pragma mark public
- (NSString *)returnCurrentSelectString {
    if (_pickViewType == PickViewType_Time) {
        return NSStringFormat(@"%@-%@-%@ %@%ld",[self returnTitleWithRow:_selectOneRow component:0],[self returnTitleWithRow:_selectTwoRow component:1],[self returnTitleWithRow:_selectThreeRow component:2] ,[self returnTitleWithRow:_selectFourRow component:3],_selectFiveRow);
    }else if (_pickViewType == PickViewType_Source) {
        return NSStringFormat(@"%ld",_selectOneRow);
    }else {
        return NSStringFormat(@"%@-%@-%@",[self returnTitleWithRow:_selectOneRow component:0],[self returnTitleWithRow:_selectTwoRow component:1],[self returnTitleWithRow:_selectThreeRow component:2]);
    }
}
- (void)setPickViewSource:(NSArray *)array {
    if (array && array.count > 0) {
        if (self.sourceArray.count > 1) {
            [self.sourceArray removeObjectsInRange:NSMakeRange(1, self.sourceArray.count - 2)];
        }
        [self.sourceArray addObjectsFromArray:array];
    }
    if (_pickViewType == PickViewType_Source) {
        [self.pickView reloadAllComponents];
        [self changeSourceSelect];
    }
}
- (void)changeSourceSelect {
    if (_sourceArray && _selectOneRow > self.sourceArray.count) {
        _selectOneRow = self.sourceArray.count - 1;
        [self.pickView selectRow:_selectOneRow inComponent:0 animated:YES];
    }else if(_selectOneRow == 0) {
        [self.pickView selectRow:_selectOneRow inComponent:0 animated:NO];
    }
}
- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray arrayWithObject:@"全部商品"];
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
    _lineColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    if (_pickViewType != PickViewType_Source) {
        _dateTimeDic = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:kDatePlistName ofType:@"plist"]];
        [self getCurrentDate:YES];
        _selectFiveRow = 0;
        _selectFourRow = 0;
        _maxOneCol = _currentYear - kMinYear;
        _selectOneRow = _maxOneCol - 1;
        _maxTwoCol = _currentMonth;
        _selectTwoRow = _maxTwoCol - 1;
        _maxThreeCol = _currentDay;
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
    if (_pickViewType != PickViewType_Source) {
        [self getCurrentDate:NO];
    }
}
//设置一个最大的范围日期
- (void)getCurrentDate:(BOOL)isFirst {
    NSDate *date = _maxDate == nil ? [NSDate date]:_maxDate;
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    BOOL isNeedReoad = !isFirst && (_currentYear != comps.year || _currentMonth != comps.month || _currentDay != comps.day) ? YES : NO;
    _currentYear = comps.year;
    _currentMonth = comps.month;
    _currentDay = comps.day;
    if (isNeedReoad && _selectOneRow + kMinYear == _currentYear) {
        _maxOneCol = _currentYear - kMinYear > _maxOneCol?_currentYear - kMinYear:_maxOneCol;
        _maxTwoCol = _maxTwoCol != _currentMonth ?_currentMonth:_maxTwoCol;
        _maxThreeCol = _maxThreeCol != _currentDay?_currentDay:_maxThreeCol;
        [self changeCurrentSelect];
        [self.pickView reloadAllComponents];
    }
}
//当修改列表的时候，当前选中的时候超出范围的时候优化
- (void)changeCurrentSelect {
    if (_selectOneRow > _maxOneCol - 1) {
        _selectOneRow = _maxOneCol - 1;
        [self.pickView selectRow:_selectOneRow inComponent:0 animated:NO];
    }
    if (_selectTwoRow > _maxTwoCol - 1) {
        _selectTwoRow = _maxTwoCol - 1;
        [self.pickView selectRow:_selectTwoRow inComponent:1 animated:NO];
    }
    if (_selectThreeRow > _maxThreeCol - 1) {
        _selectThreeRow = _maxThreeCol - 1;
        [self.pickView selectRow:_selectThreeRow inComponent:2 animated:NO];
    }
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
#pragma mark - delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source) {
        return SCREEN_WIDTH;
    }else if (_pickViewType == PickViewType_Date) {
        return SCREEN_WIDTH / 3.0;
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
    if (_pickViewType == PickViewType_Source) {
        return 1;
    }else if (_pickViewType == PickViewType_Date) {
        return 3;
    }else {
        return 5;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source) {
        return _sourceArray == nil ? 0 : _sourceArray.count;
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
    return 27;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = _lineColor;
        }
    }
    if (_pickViewType == PickViewType_Source) {
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
            pickerLabel.font = FontNornalInit(12);
            pickerLabel.textAlignment = 0;
            pickerLabel.frame = CGRectMake(42, 0, CGRectGetWidth(self.bounds), 27);
            [view addSubview:pickerLabel];
        }
        pickerLabel.text = @"全部商品";
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
    if (component == 0) {
        title = NSStringFormat(@"%ld",row + kMinYear);
    }else {
        NSString *key = component == 3?kHourKeyName:kMinuteKeyName;
        NSArray *array = [_dateTimeDic objectForKey:key];
        NSInteger index = component > 2 ? row : row + 1  ;
        title = [array objectAtIndex:index];
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickViewType == PickViewType_Source) {
        _selectOneRow = row;
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
        NSInteger maxTwo = _selectOneRow == _maxOneCol - 1 ? _currentMonth:12;;
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
    NSInteger maxDay = (_selectOneRow == _maxOneCol - 1 && _selectTwoRow == _maxTwoCol - 1) ? _currentDay:[NSDate getDaysInYear:_selectOneRow + kMinYear month:_selectTwoRow + 1];
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
