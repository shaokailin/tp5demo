//
//  PPSSCashierListVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierListVC.h"
#import "PPSSMemberListHeaderView.h"
#import "PPSSCashierListTableViewCell.h"
#import "PPSSCashierDetailVC.h"
#import "PPSSCashierModel.h"
#import "PPSSCashierListViewModel.h"
@interface PPSSCashierListVC ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSIndexPath *editIndexPath;
@property (nonatomic ,weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSMemberListHeaderView *headerView;
@property (nonatomic, strong) PPSSCashierListViewModel *viewModel;
@end

@implementation PPSSCashierListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kCashierList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _editIndexPath = nil;
}
#pragma mark - public
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSCashierListViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.cashierListArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView reloadData];
        [self endRefreshing];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.cashierListArray.count];
    }];
    [self.viewModel getCashierList:NO];
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getCashierList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getCashierList:YES];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)searchClick:(NSString *)text {
    self.viewModel.searchText = text;
    [self.viewModel getCashierList:NO];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel) {
        return self.viewModel.cashierListArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSCashierListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierListTableViewCell];
    PPSSCashierModel *model = [self.viewModel.cashierListArray objectAtIndex:indexPath.row];
    [cell setupContentWithName:model.name phone:model.phone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    _editIndexPath = indexPath;
    [self jumpCashierDetailController:CashierDetailType_Exit];
}
- (void)jumpCashierDetailController:(CashierDetailType)type {
    PPSSCashierDetailVC *detail = [[PPSSCashierDetailVC alloc]init];
    detail.actionType = type;
    if (type == CashierDetailType_Exit && _editIndexPath) {
        PPSSCashierModel *model = [self.viewModel.cashierListArray objectAtIndex:_editIndexPath.row];
        detail.cashierModel = model;
    }
    @weakify(self)
    detail.editBlock = ^(CashierDetailType actionType, PPSSCashierModel *model) {
        @strongify(self)
        if (actionType == CashierDetailType_Exit) {
            if (self.editIndexPath && self.editIndexPath.row < self.viewModel.cashierListArray.count) {
                [self.viewModel.cashierListArray replaceObjectAtIndex:self.editIndexPath.row withObject:model];
                [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:self.editIndexPath.row indexPathEnd:self.editIndexPath.row section:0 animation:UITableViewRowAnimationNone];
            }
        }else if (actionType == CashierDetailType_Add){
            if (self.viewModel.isSuccess) {
                self.viewModel.totalPage += 1;
                [self.viewModel.cashierListArray addObject:model];
                [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:self.viewModel.cashierListArray.count - 1 indexPathEnd:self.viewModel.cashierListArray.count - 1 section:0 animation:UITableViewRowAnimationBottom];
            }else {
                [self.viewModel getCashierList:YES];
            }
        }else {
            if (self.editIndexPath && self.editIndexPath.row < self.viewModel.cashierListArray.count) {
                if (self.viewModel.cashierListArray.count <= 5 && self.viewModel.totalPage > 5) {
                    self.viewModel.page = 0;
                    [self.viewModel getCashierList:YES];
                }else {
                    self.viewModel.totalPage --;
                    [self.viewModel.cashierListArray removeObjectAtIndex:self.editIndexPath.row];
                    [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Delete indexPathStart:self.editIndexPath.row indexPathEnd:self.editIndexPath.row section:0 animation:UITableViewRowAnimationTop];
                }
            }
        }
    };
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)jumpAddCashier {
    [self jumpCashierDetailController:CashierDetailType_Add];
}
#pragma mark - init
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"cashier_add" seletedIamge:nil target:self action:@selector(jumpAddCashier)];
    UITableView *tablView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tablView.rowHeight = 44;
    [tablView registerClass:[PPSSCashierListTableViewCell class] forCellReuseIdentifier:kPPSSCashierListTableViewCell];
    PPSSMemberListHeaderView *headerView = [[PPSSMemberListHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    headerView.type = 1;
    self.headerView = headerView;
    WS(ws)
    headerView.searchBlock = ^(NSString *searchText) {
        [ws searchClick:searchText];
    };
    tablView.tableHeaderView = headerView;
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
