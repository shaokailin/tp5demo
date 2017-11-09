//
//  LCHomeMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeMainVC.h"
#import "LCHomeHeaderView.h"
#import "LCHomeHotPostTableViewCell.h"
@interface LCHomeMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCHomeHeaderView *headerView;
@end

@implementation LCHomeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark private
- (void)showMeunView {
    
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHomeHotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHomeHotPostTableViewCell];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark -界面初始化
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView)];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    LCHomeHeaderView *headerView = [[LCHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 486)];
    self.headerView = headerView;
    mainTableView.tableHeaderView = headerView;
    
    [mainTableView registerNib:[UINib nibWithNibName:kLCHomeHotPostTableViewCell bundle:nil] forCellReuseIdentifier:kLCHomeHotPostTableViewCell];
    mainTableView.rowHeight = 80;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainTableView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(486);
    }];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
