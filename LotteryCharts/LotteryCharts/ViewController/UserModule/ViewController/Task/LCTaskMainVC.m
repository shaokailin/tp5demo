//
//  LCTaskMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTaskMainVC.h"
#import "LCTaskHeaderView.h"
#import "LCTaskTableViewCell.h"
#import "LSKImageManager.h"
#import "LCTaskViewModel.h"
#import "LCUserMessageVC.h"
#import "LCRankingMainVC.h"
#import "LCTeamMainVC.h"
#import "LCUserSignVC.h"
@interface LCTaskMainVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) LCTaskHeaderView *headerView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) LCTaskViewModel *viewModel;
@end

@implementation LCTaskMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"任务";
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
    [self addNotificationWithSelector:@selector(changeSignState) name:kSign_Change_Notice];
    [self addNotificationWithSelector:@selector(changeMessage) name:kMessage_Change_Notice];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
}
- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorHexadecimal(0xeeeeee, 0.1) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}
- (void)changeSignState {
    if (_viewModel && _viewModel.taskModel) {
        _viewModel.taskModel.is_sign = 1;
        [self.mainTableView reloadData];
    }
}
- (void)changeMessage {
    [self pullDownRefresh];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCTaskViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.headerView setupMoney:self.viewModel.taskModel.all_money];
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    [_viewModel getTaskMessage];
}
- (void)pullDownRefresh {
    [_viewModel getTaskMessage];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCTaskTableViewCell];
    [cell setupLeftContent:[self returnLeftTitle:indexPath.row] right:[self returnRightTitle:indexPath.row]];
    return cell;
}
- (NSString *)returnLeftTitle:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"完善资料";
            break;
        case 1:
            title = @"每日回帖";
            break;
        case 2:
            title = @"每日签到";
            break;
        case 3:
            title = @"团队签到";
            break;
        case 4:
            title = @"邀请好友";
            break;
            
        default:
            break;
    }
    return title;
}
- (NSString *)returnRightTitle:(NSInteger)index {
    NSString *title = nil;
    if (!self.viewModel.taskModel) {
        return nil;
    }
    switch (index) {
        case 0:
            title = NSStringFormat(@"已完成%@%%",self.viewModel.taskModel.fish_ing);
            break;
        case 1:
            title = self.viewModel.taskModel.today_post == 1? @"已回帖":@"未回帖";
            break;
        case 2:
            title = self.viewModel.taskModel.is_sign == 1? @"已签到":@"未签到";
            break;
        case 3:
            title = NSStringFormat(@"已签到%zd人",self.viewModel.taskModel.all_sign);
            break;
        case 4:
            title = @"获取1银币";
            break;
            
        default:
            break;
    }
    return title;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCUserMessageVC *message = [[LCUserMessageVC alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }else if (indexPath.row == 1) {
        LCRankingMainVC *ranking = [[LCRankingMainVC alloc]init];
        ranking.isChangeNavi = YES;
        [self.navigationController pushViewController:ranking animated:YES];
    }else if (indexPath.row == 2){
        LCUserSignVC *sign = [[LCUserSignVC alloc]init];
        [self.navigationController pushViewController:sign animated:YES];
    }else {
        LCTeamMainVC *team = [[LCTeamMainVC alloc]init];
        [self.navigationController pushViewController:team animated:YES];
    }
}
#pragma makr -view
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCTaskTableViewCell bundle:nil] forCellReuseIdentifier:kLCTaskTableViewCell];
    tableView.rowHeight = 44;
    LCTaskHeaderView *header = [[LCTaskHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175 + 42)];
    self.headerView = header;
    tableView.tableHeaderView = header;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    [header setupMoney:@"0"];
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
