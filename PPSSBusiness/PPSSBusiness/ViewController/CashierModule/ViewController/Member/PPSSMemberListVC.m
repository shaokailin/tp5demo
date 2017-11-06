//
//  PPSSMemberListVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberListVC.h"
#import "PPSSMemberListTableViewCell.h"
#import "PPSSMemberDetailVC.h"
#import "PPSSMemberListHeaderView.h"
#import "PPSSMemberHomeViewModel.h"
#import "PPSSMemberListModel.h"
@interface PPSSMemberListVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSMemberListHeaderView *headerView;
@property (nonatomic, strong) PPSSMemberHomeViewModel *viewModel;
@end
@implementation PPSSMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kMemberList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSMemberHomeViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.memberListArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView reloadData];
        [self endRefreshing];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.memberListArray.count];
    }];
    [self.viewModel getMemberList:NO];
}
#pragma mark - public
#pragma mark private
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getMemberList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getMemberList:YES];
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
    [self.viewModel getMemberList:NO];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel) {
        return self.viewModel.memberListArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSMemberListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSMemberListTableViewCell];
    PPSSMemberModel *model = [self.viewModel.memberListArray objectAtIndex:indexPath.row];
    [cell setupUserPhoto:model.userAvatar name:model.userName phone:model.userPhone feetotal:model.feeTotal payCount:model.userTimes userStore:model.userStore];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    PPSSMemberDetailVC *detail = [[PPSSMemberDetailVC alloc]init];
     PPSSMemberModel *model = [self.viewModel.memberListArray objectAtIndex:indexPath.row];
    detail.userId = model.userId;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 界面
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSMemberListTableViewCell class] forCellReuseIdentifier:kPPSSMemberListTableViewCell];
    PPSSMemberListHeaderView *headerView = [[PPSSMemberListHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    self.headerView = headerView;
    WS(ws)
    headerView.searchBlock = ^(NSString *searchText) {
        [ws searchClick:searchText];
    };
    tableView.tableHeaderView = headerView;
    tableView.rowHeight = 80;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
