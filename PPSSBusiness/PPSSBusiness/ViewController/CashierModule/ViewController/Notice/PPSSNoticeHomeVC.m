//
//  PPSSNoticeHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSNoticeHomeVC.h"
#import "PPSSNoticeHomeTableViewCell.h"
#import "PPSSNoticeDetailVC.h"
@interface PPSSNoticeHomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation PPSSNoticeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kNoticeList_Title_Name;
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

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSNoticeHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSNoticeHomeTableViewCell];
    [cell setupContentWithTitle:@"随机立减" date:@"2017-09-20"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSNoticeDetailVC *detail = [[PPSSNoticeDetailVC alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 界面
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSNoticeHomeTableViewCell class] forCellReuseIdentifier:kPPSSNoticeHomeTableViewCell];
    tableView.rowHeight = 44;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
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
