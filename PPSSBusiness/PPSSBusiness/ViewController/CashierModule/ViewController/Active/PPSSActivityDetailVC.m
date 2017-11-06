//
//  PPSSActivityDetailVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "PPSSActivityDetailTableViewCell.h"
#import "PPSSActivityDetailHeader1TableViewCell.h"
#import "PPSSActivityDetailHeader2TableViewCell.h"
#import "PPSSActivityDetailAttributeTableViewCell.h"
#import "PPSSActivityDetailInputTableViewCell.h"
#import "PPSSActivityDetailTimeTableViewCell.h"
#import "PPSSPiskSelectView.h"
#import "PPSSActivityDetailViewModel.h"
#import "PPSSShopListModel.h"
#import "PPSSActivityRuleTableViewCell.h"
#import "PPSSActivitySupportVC.h"
#import "PPSSActivityAlertView.h"
#import "PPSSCashierSwitchTableViewCell.h"
@interface PPSSActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, assign) BOOL isCanShowAddTime;
@property (nonatomic, assign) NSInteger addTimeCount;
@property (nonatomic, assign) NSInteger activityStateCount;
@property (nonatomic, copy) NSString *supportSting;
@property (nonatomic, strong) PPSSPiskSelectView *selectPickView;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (nonatomic, assign) ActivityTimeExitType addTimeType;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) PPSSActivityDetailViewModel *viewModel;
@end

@implementation PPSSActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kActiveAdd_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSActivityDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            NSString *alterString = nil;
            if (self.editType == 1) {
                alterString = @"添加成功";
                
            }else if (self.editType == 2) {
                alterString = @"修改成功";
                self.activityModel.promotionLimitTime = nil;
            }
            [SKHUD showMessageInView:self.view withMessage:alterString];
            [self performSelector:@selector(backToHome) withObject:nil afterDelay:1.5];
        }else {
            [self showShopLists];
        }
    } failure:nil];
    _viewModel.activityType = [self.activityModel.promotionType integerValue];
    _viewModel.editType = self.editType;
}
- (void)backToHome {
    if (self.editBlock) {
        self.editBlock(self.editType, self.activityModel);
    }
    [self navigationBackClick];
}
- (void)saveChangeActivity {
    self.activityModel.promotionTime = self.timeArray;
    [_viewModel editActivityEvent:self.activityModel];
}
- (void)closeActivityEvent:(NSInteger)state cell:(PPSSCashierSwitchTableViewCell *)cell {
    NSString *title = state == YES ? @"是否开启这个活动?" : @"是否需要禁用这个活动?";
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    @weakify(self)
    [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        if ([x integerValue] == 1) {
            @strongify(self)
            self.activityModel.closeOrOpen = state;
            [cell changeSwithWithState:state];
        }
        [KUserMessageManager hidenAlertView];
    }];
    [KUserMessageManager showAlertView:alter weight:2];
}
- (void)exitTimeAction:(PPSSActivityDetailTimeTableViewCell *)cell type:(ActivityTimeExitType)type {
    if (_editType != 1) {
        return;
    }
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSInteger index = indexPath.row;
    if (type != ActivityTimeExitType_Delete) {
        self.selectIndexPath = indexPath;
        self.addTimeType = type;
        self.selectPickView.type = PickViewType_Time;
        self.selectPickView.isAutoHidenForSure = NO;
        self.selectPickView.titleText = @"选择时间";
        [self.selectPickView showInView];
    }else {
        if (self.addTimeCount > 1) {
            self.addTimeCount -= 1;
            if (index - 6 < self.timeArray.count) {
                [self.timeArray removeObjectAtIndex:index - 6];
            }
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Delete indexPathStart:index+1 indexPathEnd:index+ 1 section:0 animation:UITableViewRowAnimationTop];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:6 indexPathEnd:5 + self.addTimeCount + 1 section:0 animation:UITableViewRowAnimationNone];
        }
    }
}
- (void)showIntersityAlert {
    NSString *title = nil;
    if (self.viewModel.activityType == 2) {
        title = @"如活动折扣=10%，则消费100元，消费者可集10个本店积分。";
    }else {
        title = @"活动力度 15%表示用户每笔消费的15%将以本店余额(类似储值)的形式按照规则发放给用户。用户可将本店余额在下次消费进行抵用。";
    }
    PPSSActivityAlertView *alertView = [[PPSSActivityAlertView alloc]initWithAlertTitle:title];
    [alertView showInView];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9 + (self.isCanShowAddTime ? 1 : 0) + self.addTimeCount + self.activityStateCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((!_isCanShowAddTime && indexPath.row == 5) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 1) || (_editType != 1 && (((!_isCanShowAddTime && indexPath.row == 9 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 5)) || ((!_isCanShowAddTime && indexPath.row == 11 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 7))))) {
        return 10;
    }
    if ((!_isCanShowAddTime && indexPath.row == 8 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 4)) {
        return 208;
    }
    if (!_isCanShowAddTime && indexPath.row == 7 && [self.activityModel.promotionType integerValue] == 2){
        return 100;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((!_isCanShowAddTime && indexPath.row == 5) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 1)|| (_editType != 1 && (((!_isCanShowAddTime && indexPath.row == 9 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 5)) || ((!_isCanShowAddTime && indexPath.row == 11 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 7))))) {//空白线
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else if ((!_isCanShowAddTime && indexPath.row == 8 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 4)) {//活动介绍
        PPSSActivityDetailInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailInputTableViewCell];
        WS(ws)
        cell.inputBlock = ^(NSString *text) {
            ws.activityModel.promotionBody = text;
        };
        [cell setupInputBodyText:self.activityModel.promotionBody];
        return cell;
    }else if (_editType != 1 && ((!_isCanShowAddTime && indexPath.row == 10 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 6))){
        PPSSCashierSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierSwitchTableViewCell];
        [cell setupSwitchContentWithTitle:@"活动状态" isSwitch:self.activityModel.closeOrOpen];
        @weakify(self)
        cell.switchBlock = ^(id cell, NSInteger isOn) {
            @strongify(self)
           [cell changeSwithWithState:!isOn];
           [self closeActivityEvent:isOn cell:cell];
        };
        return cell;

    }else if ((!_isCanShowAddTime && indexPath.row == 6) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 2)) {//活动力度
        PPSSActivityDetailAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailAttributeTableViewCell];
        [cell setupContentWithSuport:self.activityModel.promotionIntensity];
        [cell setupSuportType:[self.activityModel.promotionType integerValue] == 2? 2:1];
        @weakify(self)
        cell.intensityBlock = ^(NSInteger type) {
          @strongify(self)
            [self showIntersityAlert];
        };
        return cell;
    }else if (indexPath.row == 2){//第1个标题活动时间
        PPSSActivityDetailHeader1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailHeader1TableViewCell];
        return cell;
    }else if (_isCanShowAddTime && indexPath.row == 5){//添加时间段的按钮
        PPSSActivityDetailHeader2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailHeader2TableViewCell];
        WS(ws)
        cell.addBlock = ^(NSInteger type) {
            [ws addTimeAction];
        };
        return cell;
    }else if (_isCanShowAddTime && (indexPath.row > 5 && indexPath.row < 6 + _addTimeCount)) {//添加时间段
        PPSSActivityDetailTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailTimeTableViewCell];
        NSInteger index = indexPath.row - 6;
        NSDictionary *dict = [self.timeArray objectAtIndex:index];
        BOOL isShow = (_addTimeCount > 1 ? YES:NO);
        [cell setupContentWithStart:[dict objectForKey:@"startTime"] end:[dict objectForKey:@"endTime"] isShowDele:isShow index:indexPath.row - 5];
        WS(ws)
        cell.exitBlock = ^(PPSSActivityDetailTimeTableViewCell *clickCell, ActivityTimeExitType type) {
            [ws exitTimeAction:clickCell type:type];
        };
        return cell;
    }else if (!_isCanShowAddTime && indexPath.row == 7 && [self.activityModel.promotionType integerValue] == 2){
        PPSSActivityRuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityRuleTableViewCell];
        @weakify(self)
        cell.ruleBlock = ^(NSInteger type, NSString *rule) {
            @strongify(self)
            if (type == 1) {
                self.activityModel.setPoint = rule;
            }else {
                self.activityModel.pointChangeBalance = rule;
            }
        };
        [cell setupPointValue:self.activityModel.setPoint money:self.activityModel.pointChangeBalance isEdit:self.editType == 1];
        return cell;
    }else {
        PPSSActivityDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailTableViewCell];
        NSInteger index = indexPath.row;
        if ((!_isCanShowAddTime && index == 7 + _addTimeCount) || (_isCanShowAddTime && index == 5 + _addTimeCount + 3)) {
            index = 6;
        }
        [cell setupContentWithLeft:[self returnLeftTitle:index] right:[self returnRightTitle:index]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (((!_isCanShowAddTime && indexPath.row == 6) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 2)) && _editType == 1 ) {
        self.selectIndexPath = indexPath;
        if ([self.activityModel.promotionType integerValue] == 2) {
            self.selectPickView.type = PickViewType_Discount;
            self.selectPickView.titleText = @"选择活动折扣";
        }else {
            self.selectPickView.type = PickViewType_Activity;
            self.selectPickView.titleText = @"选择活动力度";
        }
        self.selectPickView.isAutoHidenForSure = YES;
        [self.selectPickView showInView];
        
    }else if(indexPath.row == 4 || (indexPath.row < 5 && indexPath.row != 2 && indexPath.row != 0 && _editType == 1)) {
        self.selectIndexPath = indexPath;
        if (indexPath.row == 1) {
            if (![self.viewModel getShopList]) {
                [self showShopLists];
            }
        }else {
            if (self.isCanShowAddTime) {
                self.selectPickView.type = PickViewType_Date;
            }else {
                self.selectPickView.type = PickViewType_DateAndTime;
            }
            self.selectPickView.isAutoHidenForSure = YES;
            self.selectPickView.titleText = @"选择时间";
            [self.selectPickView showInView];
        }
    }else if (((!_isCanShowAddTime && indexPath.row == 7 + _addTimeCount) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 3)) && _editType == 1) {
        PPSSActivitySupportVC *support = [[PPSSActivitySupportVC alloc]init];
        support.timeString = self.activityModel.periodOfValidity;
        @weakify(self)
        support.block = ^(NSString *content) {
            @strongify(self)
            self.activityModel.periodOfValidity = content;
            NSInteger index = _isCanShowAddTime ? indexPath.row == 5 + _addTimeCount + 3 : 7 + _addTimeCount;
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:index indexPathEnd:index section:0 animation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:support animated:YES];
    }
}
- (void)showShopLists {
    self.selectPickView.titleText = @"选择门店";
    [self.selectPickView setPickViewSource:self.viewModel.shopListArray];
    self.selectPickView.type = PickViewType_Source;
    self.selectPickView.isAutoHidenForSure = YES;
    [self.selectPickView showInView];
}
- (void)setupSelectTitle:(NSString *)title {
    if (_selectIndexPath) {
        if (_selectIndexPath.row < 5) {
            PPSSActivityDetailTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:_selectIndexPath];
            if (_selectIndexPath.row == 1) {
                NSInteger index = [title integerValue];
                if (index == 0) {
                    self.activityModel.shopId = @"0";
                    self.activityModel.shopName = @"全部门店";
                }else {
                    PPSSShopModel *model = [self.viewModel.shopListArray objectAtIndex:index - 1];
                    self.activityModel.shopId = model.shopId;
                    self.activityModel.shopName = model.shopName;
                }
                [cell setupRightString:self.activityModel.shopName];
            }else {
                if (!self.isCanShowAddTime) {
                    title = NSStringFormat(@"%@:00",title);
                }
                if (_selectIndexPath.row == 3) {
                    self.activityModel.promotionStartTime = title;
                }else {
                    self.activityModel.promotionEndTime = title;
                }
                [cell setupRightString:title];
            }
        }else if ((!_isCanShowAddTime && _selectIndexPath.row == 6) || (_isCanShowAddTime && _selectIndexPath.row == 5 + _addTimeCount + 2)) {
            self.activityModel.promotionIntensity = title;
            PPSSActivityDetailAttributeTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:_selectIndexPath];
            [cell setupContentWithSuport:self.activityModel.promotionIntensity];
        } else {
            [self addTimeWithTile:title isStart:(_addTimeType == ActivityTimeExitType_Start)];
        }
        _selectIndexPath = nil;
    }
}

- (BOOL)selectTimeCompare:(NSString *)leftTime right:(NSString *)rightTime {
    NSDate *startTime = [NSDate stringTransToDate:leftTime withFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *endTime = [NSDate stringTransToDate:rightTime withFormat:@"yyyy-MM-dd hh:mm:ss"];
    if ([startTime timeIntervalSinceDate:endTime] > 0) {
        return NO;
    }
    return YES;
}

#pragma mark -时间段的事件操作
- (void)addTimeAction {
    if (self.addTimeCount < 3) {
        NSMutableDictionary *beforeDict = [self.timeArray objectAtIndex:self.addTimeCount - 1];
        NSString *start = [beforeDict objectForKey:@"startTime"];
        NSString *end = [beforeDict objectForKey:@"endTime"];
        if (!KJudgeIsNullData(start) || !KJudgeIsNullData(end)) {
            [SKHUD showMessageInView:self.view withMessage:NSStringFormat(@"需要先完善完时段%zd,才能继续添加新的时段",self.addTimeCount)];
            return;
        }
        NSInteger index = 5 + self.addTimeCount;
        self.addTimeCount += 1;
        [self.timeArray addObject:[self setupTimeSlot]];
        [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:index + 1 indexPathEnd:index + 1 section:0 animation:UITableViewRowAnimationBottom];
        if ((self.addTimeCount - 1) == 1) {
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:6 indexPathEnd:6 section:0 animation:UITableViewRowAnimationNone];
        }
    }else {
        [SKHUD showMessageInView:self.view withMessage:@"最多只能加3个时间段"];
    }
}
- (void)addTimeWithTile:(NSString *)title isStart:(BOOL)isStart{
    NSInteger index = self.selectIndexPath.row - 6;
    NSString *before = [self returnCompareValueWithIsBefore:YES isStart:isStart index:index];
    NSInteger beforeResult = [self compareTimeForLeftTime:before rightTime:title];
    if (beforeResult != -1) {
        [SKHUD showMessageInView:self.view withMessage:@"选择的时间 要大于 已选择的前面时间段的时间"];
        return;
    }
    NSString *after = [self returnCompareValueWithIsBefore:NO isStart:isStart index:index];
    if (KJudgeIsNullData(after)) {
        NSInteger afterResult = [self compareTimeForLeftTime:title rightTime:after];
        if (afterResult != -1) {
            [SKHUD showMessageInView:self.view withMessage:@"选择的时间 要小于 已选择的后面时间段的时间"];
            return;
        }
    }
    PPSSActivityDetailTimeTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:_selectIndexPath];
    if (_addTimeType == ActivityTimeExitType_Start) {
        [cell setupContentWithStart:title end:nil];
    }else if (_addTimeType == ActivityTimeExitType_End){
        [cell setupContentWithStart:nil end:title];
    }
    NSMutableDictionary *currentDict = [[self.timeArray objectAtIndex:index] mutableCopy];
    if (isStart) {
        [currentDict setValue:title forKey:@"startTime"];
    }else {
        [currentDict setValue:title forKey:@"endTime"];
    }
    [self.timeArray replaceObjectAtIndex:index withObject:currentDict];
    [self.selectPickView cancleSelectedClick];
    _addTimeType = -1;
}
/**
 获取要比较的时间

 @param isBefore 日期往前查找还是往后
 @param isStart 是否是开始时间还是结束时间
 @param index 当前选择的地址
 @return 需要比较的时间
 */
- (NSString *)returnCompareValueWithIsBefore:(BOOL)isBefore isStart:(BOOL)isStart index:(NSInteger)index {
    NSString *compareString = @"";
    if (isBefore) {
        for (NSInteger i = index; i>= 0 ; i--) {
            NSDictionary *currentDict = [self.timeArray objectAtIndex:i];
            NSString *start = [currentDict objectForKey:@"startTime"];
            NSString *end = [currentDict objectForKey:@"endTime"];
            if (!isStart && i == index && KJudgeIsNullData(start)) {
                compareString = start;
                break;
            }else if(i != index) {
                if (KJudgeIsNullData(end)) {
                    compareString = end;
                    break;
                }else if (KJudgeIsNullData(start)){
                    compareString = start;
                    break;
                }
            }
        }
    }else {
        for (NSInteger i = index; i < self.addTimeCount; i++) {
            NSDictionary *currentDict = [self.timeArray objectAtIndex:i];
            NSString *start = [currentDict objectForKey:@"startTime"];
            NSString *end = [currentDict objectForKey:@"endTime"];
            if (isStart && i == index && KJudgeIsNullData(end)) {
                compareString = end;
                break;
            }else if(i != index) {
                if (KJudgeIsNullData(start)) {
                    compareString = start;
                    break;
                }else if (KJudgeIsNullData(end)){
                    compareString = end;
                    break;
                }
            }
        }
    }
    return compareString;
}
//-1 左 < 右  0 =  1 左》右
- (NSInteger)compareTimeForLeftTime:(NSString *)left rightTime:(NSString *)right {
    if (!KJudgeIsNullData(left)) {
        return -1;
    }
    if (!KJudgeIsNullData(right)) {
        return 1;
    }
    NSArray *timeLeftArray = [left componentsSeparatedByString:@":"];
    NSArray *timeRightArray = [right componentsSeparatedByString:@":"];
    NSComparisonResult result = [[timeLeftArray objectAtIndex:0] compare:[timeRightArray objectAtIndex:0]];
    if (result == 0) {
        return [[timeLeftArray objectAtIndex:1] compare:[timeRightArray objectAtIndex:1]];
    }else {
        return result;
    }
}

- (NSDictionary *)setupTimeSlot {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"startTime",@"",@"endTime", nil];
    return dict;
}

#pragma mark 界面的初始化
- (PPSSPiskSelectView *)selectPickView {
    if (!_selectPickView) {
        _selectPickView = [[PPSSPiskSelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbarHeight:self.tabbarBetweenHeight];
        @weakify(self)
        _selectPickView.pickBlock = ^(PickViewType type, NSString *content) {
            @strongify(self)
            [self setupSelectTitle:content];
        };
        [_selectPickView setMinDate:[NSDate date]];
        [[UIApplication sharedApplication].keyWindow addSubview:_selectPickView];
    }
    return _selectPickView;
}
- (void)initializeMainView {
    self.activityStateCount = self.editType == 2 ? 3:0;
    self.isCanShowAddTime = [self.activityModel.promotionType integerValue] == 0 ? YES:NO;
    if (self.isCanShowAddTime) {
        if (self.activityModel.promotionTime && [self.activityModel.promotionTime isKindOfClass:[NSArray class]]) {
            self.timeArray = [NSMutableArray arrayWithArray:self.activityModel.promotionTime];
        }else {
            self.timeArray = [NSMutableArray arrayWithObjects:[self setupTimeSlot], nil];
        }
    }
    self.addTimeCount = (self.isCanShowAddTime == YES || [self.activityModel.promotionType integerValue] == 2) ? 1:0;
    
   TPKeyboardAvoidingTableView *tableView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    self.mainTableView = tableView;
    [tableView registerClass:[PPSSActivityDetailTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailTableViewCell];
    [tableView registerClass:[PPSSActivityDetailInputTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailInputTableViewCell];
    [tableView registerClass:[PPSSActivityDetailHeader1TableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailHeader1TableViewCell];
    [tableView registerClass:[PPSSActivityDetailHeader2TableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailHeader2TableViewCell];
    [tableView registerClass:[PPSSActivityDetailAttributeTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailAttributeTableViewCell];
    [tableView registerClass:[PPSSActivityDetailTimeTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailTimeTableViewCell];
    [tableView registerClass:[PPSSActivityRuleTableViewCell class] forCellReuseIdentifier:kPPSSActivityRuleTableViewCell];
    [tableView registerClass:[PPSSCashierSwitchTableViewCell class] forCellReuseIdentifier:kPPSSCashierSwitchTableViewCell];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 44 + ws.tabbarBetweenHeight, 0));
    }];
    UIButton *saveBtn = [PPSSPublicViewManager initAPPThemeBtn:@"保存" font:15 target:self action:@selector(saveChangeActivity)];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
        make.top.equalTo(tableView.mas_bottom);
    }];
}
- (NSString *)returnLeftTitle:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"活动类型";
            break;
        case 1:
            title = @"选择门店";
            break;
        case 3:
            title = @"开始时间";
            break;
        case 4:
            title = @"结束时间";
            break;
        case 6:
            title = @"现金券有效期";
            break;
        default:
            break;
    }
    return title;
}
- (NSString *)returnRightTitle:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = self.activityModel.promotionTitle;
            break;
        case 1:
            title = KJudgeIsNullData(self.activityModel.shopName)?self.self.activityModel.shopName: @"请选择参与活动门店";
            break;
        case 3:
            title = KJudgeIsNullData(self.activityModel.promotionStartTime)?self.activityModel.promotionStartTime: @"选择时间";
            break;
        case 4:
            title = KJudgeIsNullData(self.activityModel.promotionEndTime)?self.activityModel.promotionEndTime: @"选择时间";
            break;
        case 6:
            title = KJudgeIsNullData(self.activityModel.periodOfValidity)? NSStringFormat(@"%@天",self.activityModel.periodOfValidity): @"请输入 如30天";
            break;
        default:
            break;
    }
    return title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
