//
//  LCUserSignVC.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserSignVC.h"
#import "LCUserSignViewModel.h"
#import "LSKImageManager.h"
#import "LCSignHeaderView.h"
#import "LCSignTableViewCell.h"
@interface LCUserSignVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) LCSignHeaderView *headerView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) LCUserSignViewModel *viewModel;

@end

@implementation LCUserSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.navigationItem.title = @"签到记录";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
}
- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorHexadecimal(0x000000, 0.4) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCUserSignViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        if (identifier == 0) {
            @strongify(self)
            [self.mainTableView reloadData];
            self.headerView.isSign = self.viewModel.messageModel.today_sign;
            [self.headerView changeSingAll:self.viewModel.messageModel.this_week_sign_list.mutableCopy];
            [self.headerView setupSignIdentifier:self.viewModel.messageModel.this_week_sign_list.mutableCopy];
            [self.mainTableView.mj_header endRefreshing];
        }else {
            [self bindSignal];
            self.headerView.isSign = YES;
            [self.headerView signForToday:[[NSDate date]getWeekIndex]];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    [self.viewModel getSignMessage];
}

- (void)pullDownRefresh {
    [self.viewModel getSignMessage];
}

- (void)signClick {
    [self.viewModel userSignClickEvent];
}


#pragma mark -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSignTableViewCell];
    if (_viewModel && _viewModel.messageModel) {
        [cell setupContentWithIndex:indexPath.section content:indexPath.section == 0?self.viewModel.messageModel.earn_sign_week:self.viewModel.messageModel.earn_sign_total];
    }else {
        [cell setupContentWithIndex:indexPath.section content:0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

//https://gitee.com/SpuerMmm/hua_ran_coin.git
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
    NSString *title = section == 0? @"本周":@"我的签到";
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:title font:15 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [headerView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(20);
        make.centerY.equalTo(headerView);
    }];
    return headerView;
}

#pragma makr -view
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCSignTableViewCell bundle:nil] forCellReuseIdentifier:kLCSignTableViewCell];
    tableView.rowHeight = 44;
    LCSignHeaderView *header = [[LCSignHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250 + 52)];
    self.headerView = header;
    
    tableView.tableHeaderView = header;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    header.signBlock = ^(BOOL sign) {
        [ws signClick];
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
