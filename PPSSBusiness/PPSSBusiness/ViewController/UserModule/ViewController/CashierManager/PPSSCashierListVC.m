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
@interface PPSSCashierListVC ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic ,weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSMemberListHeaderView *headerView;
@end

@implementation PPSSCashierListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kCashierList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark - public
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)searchClick:(NSString *)text {
    
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSCashierListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierListTableViewCell];
    [cell setupContentWithName:@"凯先生" phone:@"18850565545"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    PPSSCashierDetailVC *detail = [[PPSSCashierDetailVC alloc]init];
    detail.actionType = CashierDetailType_Exit;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)jumpAddCashier {
    PPSSCashierDetailVC *detail = [[PPSSCashierDetailVC alloc]init];
    detail.actionType = CashierDetailType_Add;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - init
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"cashier_add" seletedIamge:nil target:self action:@selector(jumpAddCashier)];
    UITableView *tablView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tablView.rowHeight = 44;
    [tablView registerClass:[PPSSCashierListTableViewCell class] forCellReuseIdentifier:kPPSSCashierListTableViewCell];
    PPSSMemberListHeaderView *headerView = [[PPSSMemberListHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    self.headerView = headerView;
    WS(ws)
    headerView.searchBlock = ^(NSString *searchText) {
        [ws searchClick:searchText];
    };
    tablView.tableHeaderView = headerView;
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
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
