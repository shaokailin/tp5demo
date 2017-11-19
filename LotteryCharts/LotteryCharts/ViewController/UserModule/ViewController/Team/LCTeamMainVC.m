//
//  LCTeamMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamMainVC.h"
#import "LCTeamHeaderView.h"
#import "LCTeamTableViewCell.h"
#import "LSKImageManager.h"
@interface LCTeamMainVC ()
{
    NSInteger _showType;
    BOOL _isChange;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, weak) LCTeamHeaderView *headerView;
@end

@implementation LCTeamMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.title = @"我的团队";
    [self addNavigationBackButton];
    [self initializeMainView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        _isChange = NO;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isChange = YES;
}
- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorRGBA(0, 0, 0, 0.3) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)changeShowClick:(NSInteger)type {
    _showType = type;
    [self.headerView setupContentWithLineCount:@"12" allCount:@"30"];
    [self.mainTableView reloadData];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCTeamTableViewCell];
    [cell setupContentWithPhoto:nil name:@"凯先生" userId:@"码师ID:123456" glodCount:@"1234.00" yinbiCount:@"234234.00" type:_showType state:indexPath.row % 2];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)initializeMainView {
    _showType = 0;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCTeamTableViewCell bundle:nil] forCellReuseIdentifier:kLCTeamTableViewCell];
    tableView.rowHeight = 80;
    LCTeamHeaderView *headerView = [[LCTeamHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 217)];
    self.headerView = headerView;
    [headerView setupContentWithLineCount:@"12" allCount:@"30"];
    tableView.tableHeaderView = headerView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
    }];
    headerView.teamBlock = ^(NSInteger type) {
        [ws changeShowClick:type];
    };
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
