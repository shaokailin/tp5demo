//
//  LCGuessMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainVC.h"
#import "PopoverView.h"
#import "LCRechargeMainVC.h"
#import "LCGuessMainHeaderView.h"
#import "LCGuessMainTableViewCell.h"
@interface LCGuessMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;

@end

@implementation LCGuessMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)showMeunView:(UIButton *)btn {
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
    popoverView.showShade = YES;
    [popoverView showToView:btn withActions:[self neumActions]];
}
- (void)cellClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LSKLog(@"%zd",indexPath.row);
}
- (void)moreClick:(NSInteger)index {
    LSKLog(@"%zd",index);
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
#pragma mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCGuessMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCGuessMainTableViewCell];
    [cell setupContentWithPhoto:nil name:@"凯先生" userId:@"码师ID:123456" postId:@"帖子ID:123456" pushTime:@"1小时前发布" money:@"100" count:@"8" openTime:@"2017年10月12日  20:40"];
    WS(ws)
    cell.cellBlock = ^(id clickCell) {
        [ws cellClick:clickCell];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }else {
        return 50;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LCGuessMainHeaderView *headerView = [[LCGuessMainHeaderView alloc]init];
    WS(ws)
    headerView.moreBlock = ^(NSInteger index) {
        [ws moreClick:index];
    };
    [headerView setupContentWithTime:@"2017年10月21日   星期一" count:@"211条新竞争"];
    headerView.tag = 200 + section;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (NSArray<PopoverAction *> *)neumActions {
    @weakify(self)
    PopoverAction *multichatAction = [PopoverAction actionWithImage:nil title:@"发帖" handler:^(PopoverAction *action) {
        
    }];
    PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"充值" handler:^(PopoverAction *action) {
        @strongify(self)
        LCRechargeMainVC *recgarge = [[LCRechargeMainVC alloc]init];
        recgarge.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recgarge animated:YES];
    }];
    return @[multichatAction, addFriAction];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView:)];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStyleGrouped separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCGuessMainTableViewCell bundle:nil] forCellReuseIdentifier:kLCGuessMainTableViewCell];
    mainTableView.rowHeight = 100;
    mainTableView.tableFooterView = [UIView new];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
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
