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
@interface PPSSMemberListVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSMemberListHeaderView *headerView;
@end

@implementation PPSSMemberListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kMemberList_Title_Name;
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
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSMemberListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSMemberListTableViewCell];
    [cell setupUserPhoto:nil name:@"凯先生" phone:@"18850565545" storedValue:@"50" integral:@"2000" payCount:@"10000"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    PPSSMemberDetailVC *detail = [[PPSSMemberDetailVC alloc]init];
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
