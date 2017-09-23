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
#import "PPSSActivitySupportVC.h"
@interface PPSSActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, assign) BOOL isCanShowAddTime;
@property (nonatomic, assign) NSInteger addTimeCount;
@property (nonatomic, copy) NSString *supportSting;
@end

@implementation PPSSActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kActiveAdd_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    
}
- (void)saveChangeActivity {
    
}
- (void)exitTimeAction:(PPSSActivityDetailTimeTableViewCell *)cell type:(ActivityTimeExitType)type {
    NSInteger index = [self.mainTableView indexPathForCell:cell].row;
    if (type == ActivityTimeExitType_Start) {
        
    }else if (type == ActivityTimeExitType_End){
        
    }else {
        if (self.addTimeCount > 1) {
            self.addTimeCount -= 1;
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Delete indexPathStart:index+1 indexPathEnd:index+ 1 section:0 animation:UITableViewRowAnimationTop];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:6 indexPathEnd:5 + self.addTimeCount + 1 section:0 animation:UITableViewRowAnimationNone];
        }
    }
}
- (void)addTimeAction {
    NSInteger index = 5 + self.addTimeCount;
    self.addTimeCount += 1;
    [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:index + 1 indexPathEnd:index + 1 section:0 animation:UITableViewRowAnimationBottom];
    if ((self.addTimeCount - 1) == 1) {
        [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:6 indexPathEnd:6 section:0 animation:UITableViewRowAnimationNone];
    }
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8 + (self.isCanShowAddTime ? 1 : 0) + self.addTimeCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((!_isCanShowAddTime && indexPath.row == 5) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 1)) {
        return 10;
    }
    if ((!_isCanShowAddTime && indexPath.row == 7) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 3)) {
        return 208;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((!_isCanShowAddTime && indexPath.row == 5) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 1)) {
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else if ((!_isCanShowAddTime && indexPath.row == 7) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 3)) {
        PPSSActivityDetailInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailInputTableViewCell];
        return cell;
    }else if ((!_isCanShowAddTime && indexPath.row == 6) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 2)) {
        PPSSActivityDetailAttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailAttributeTableViewCell];
        [cell setupContentWithSuport:self.supportSting];
        return cell;
    }else if (indexPath.row == 2){
        PPSSActivityDetailHeader1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailHeader1TableViewCell];
        return cell;
    }else if (_isCanShowAddTime && indexPath.row == 5){
        PPSSActivityDetailHeader2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailHeader2TableViewCell];
        WS(ws)
        cell.addBlock = ^(NSInteger type) {
            [ws addTimeAction];
        };
        return cell;
    }else if (_isCanShowAddTime && (indexPath.row > 5 && indexPath.row < 6 + _addTimeCount)) {
        PPSSActivityDetailTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailTimeTableViewCell];
        BOOL isShow = (_addTimeCount > 1 ? YES:NO);
        [cell setupContentWithStart:nil end:nil isShowDele:isShow index:indexPath.row - 5];
        WS(ws)
        cell.exitBlock = ^(PPSSActivityDetailTimeTableViewCell *clickCell, ActivityTimeExitType type) {
            [ws exitTimeAction:clickCell type:type];
        };
        return cell;
    }else {
        PPSSActivityDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityDetailTableViewCell];
        [cell setupContentWithLeft:[self returnLeftTitle:indexPath.row] right:[self returnRightTitle:indexPath.row]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((!_isCanShowAddTime && indexPath.row == 6) || (_isCanShowAddTime && indexPath.row == 5 + _addTimeCount + 2)) {
        PPSSActivitySupportVC *supportVC = [[PPSSActivitySupportVC alloc]init];
        WS(ws)
        supportVC.block = ^(NSString *content) {
            ws.supportSting = content;
            [ws.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:indexPath.row indexPathEnd:indexPath.row section:0 animation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:supportVC animated:YES];
    }
}
- (void)initializeMainView {
    self.isCanShowAddTime = (_activityType == 1 || _activityType == 2) ? YES:NO;
    self.addTimeCount = self.isCanShowAddTime == YES ? 1:0;
   TPKeyboardAvoidingTableView *tableView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    self.mainTableView = tableView;
    [tableView registerClass:[PPSSActivityDetailTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailTableViewCell];
    [tableView registerClass:[PPSSActivityDetailInputTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailInputTableViewCell];
    [tableView registerClass:[PPSSActivityDetailHeader1TableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailHeader1TableViewCell];
    [tableView registerClass:[PPSSActivityDetailHeader2TableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailHeader2TableViewCell];
    [tableView registerClass:[PPSSActivityDetailAttributeTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailAttributeTableViewCell];
    [tableView registerClass:[PPSSActivityDetailTimeTableViewCell class] forCellReuseIdentifier:kPPSSActivityDetailTimeTableViewCell];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    UIButton *saveBtn = [PPSSPublicViewManager initAPPThemeBtn:@"保存" font:15 target:self action:@selector(saveChangeActivity)];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
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
            
        default:
            break;
    }
    return title;
}
- (NSString *)returnRightTitle:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = self.activityTitle;
            break;
        case 1:
            title = @"请选择参与活动门店";
            break;
        case 3:
            title = @"选择时间";
            break;
        case 4:
            title = @"选择时间";
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
