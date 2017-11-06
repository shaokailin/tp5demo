//
//  PPSSActivityListVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityListVC.h"
#import "PPSSActivityListTableViewCell.h"
#import "PPSSActivitySelectTableViewCell.h"
#import "PPSSActivityMessageTableViewCell.h"
#import "PPSSActivityDetailVC.h"
#import "PPSSActivityListViewModel.h"
#import "PPSSActivityModel.h"
static NSString * const kActivityNamePlistName = @"ActivityName";
@interface PPSSActivityListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_activityTypeArr;
    NSInteger _power;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) PPSSActivityListViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;
@end

@implementation PPSSActivityListVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _index = -1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kActiveList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark - public
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSActivityListViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.activityListArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView reloadData];
        [self endRefreshing];
    }];
    [self.viewModel getActivityList:NO];
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getActivityList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getActivityList:YES];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)addActivityAction:(PPSSActivityMessageTableViewCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dict = [_activityTypeArr objectAtIndex:indexPath.row];
    NSString *actId = [dict objectForKey:@"actId"];
    [self jumpDetailView:ActivityDetailType_Add actId:actId actTitle:[dict objectForKey:@"actTitle"]];
}
- (void)showListType:(NSInteger)type {
    self.viewModel.state = type;
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = _activityTypeArr.count + 1;
    if (self.viewModel) {
        count += self.viewModel.activityListArray.count;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _activityTypeArr.count) {
        PPSSActivityMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityMessageTableViewCell];
        NSDictionary *dict = [_activityTypeArr objectAtIndex:indexPath.row];
        [cell setupContentWithTitle:[dict objectForKey:@"actTitle"] detail:[dict objectForKey:@"detail"] icon:[dict objectForKey:@"icon"]];
        WS(ws)
        cell.addBlock = ^(PPSSActivityMessageTableViewCell *clickCell) {
            [ws addActivityAction:clickCell];
        };
        return cell;
    }else if (indexPath.row == _activityTypeArr.count) {
        PPSSActivitySelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivitySelectTableViewCell];
        WS(ws)
        cell.selectBlock = ^(NSInteger type) {
            [ws showListType:type];
        };
        return cell;
    }else {
        PPSSActivityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityListTableViewCell];
        NSInteger index = (indexPath.row - _activityTypeArr.count - 1);
        PPSSActivityModel *model = [self.viewModel.activityListArray objectAtIndex:index];
        [cell setupContentWithTime:model.promotionLimitTime sendMoney:model.promotionMoney count:model.promotionUsers money:model.promotionPrice activity:model.promotionIntensity type:[model.promotionType integerValue] progress:[model.promotionPercent floatValue] title:model.promotionTitle isClose:model.closeOrOpen];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _activityTypeArr.count) {
        return 80;
    }else if (indexPath.row == _activityTypeArr.count) {
        return 50;
    }else {
        return 98;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_power != 2) {
        if (indexPath.row > _activityTypeArr.count) {
            _index = (indexPath.row - _activityTypeArr.count - 1);
            PPSSActivityModel *model = [self.viewModel.activityListArray objectAtIndex:_index];
            [self jumpDetailView:ActivityDetailType_Exit actId:model.promotionType actTitle:model.promotionTitle];
        }else if(indexPath.row < _activityTypeArr.count) {
            NSDictionary *dict = [_activityTypeArr objectAtIndex:indexPath.row];
            NSString *actId = [dict objectForKey:@"actId"];
            [self jumpDetailView:ActivityDetailType_Add actId:actId actTitle:[dict objectForKey:@"actTitle"]];
        }
    }
}
- (void)jumpDetailView:(ActivityDetailType)editType actId:(NSString *)actId actTitle:(NSString *)actTitle  {
    PPSSActivityDetailVC *detailVC = [[PPSSActivityDetailVC alloc]init];
    if (editType == ActivityDetailType_Exit && _index != -1) {
        PPSSActivityModel *model = [self.viewModel.activityListArray objectAtIndex:_index];
        if ([model.shopId integerValue] == 0 && !KJudgeIsNullData(model.shopName)) {
            model.shopName = @"全部门店";
        }
        detailVC.activityModel = model;
    }else {
        PPSSActivityModel *model = [[PPSSActivityModel alloc]init];
        model.promotionType = actId;
        model.promotionTitle = actTitle;
        detailVC.activityModel = model;
    }
    @weakify(self)
    detailVC.editBlock = ^(NSInteger editType, PPSSActivityModel *model) {
        @strongify(self)
        if (editType == 2) {
            if (_index != -1 && _index < self.viewModel.activityListArray.count) {
                [self.viewModel.activityListArray replaceObjectAtIndex:_index withObject:model];
                NSInteger row = _index + _activityTypeArr.count + 1;
                [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:row indexPathEnd:row section:0 animation:UITableViewRowAnimationNone];
            }
        }else if (editType == 1){
            if (self.viewModel.page == 0 && self.viewModel.isSuccess) {
                [self.viewModel getActivityList:YES];
            }
        }
    };
    detailVC.editType = editType;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)initializeMainView {
    _power = [KUserMessageManager.power integerValue];
    if (_power != 2) {
        _activityTypeArr = [NSArray arrayWithPlist:kActivityNamePlistName];
    }else {
        _activityTypeArr = [NSArray array];
    }
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSActivityListTableViewCell class] forCellReuseIdentifier:kPPSSActivityListTableViewCell];
    [tableView registerClass:[PPSSActivitySelectTableViewCell class] forCellReuseIdentifier:kPPSSActivitySelectTableViewCell];
    [tableView registerClass:[PPSSActivityMessageTableViewCell class] forCellReuseIdentifier:kPPSSActivityMessageTableViewCell];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
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
