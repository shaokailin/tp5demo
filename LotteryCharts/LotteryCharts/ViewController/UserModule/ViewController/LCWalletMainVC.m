//
//  LCWalletMainVC.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWalletMainVC.h"
#import "LSKImageManager.h"
#import "LCWalletHeaderView.h"
#import "LCWalletIconTableViewCell.h"
#import "LCWalletMoneyTableViewCell.h"
#import "LCWalletTitleTableViewCell.h"
#import "LCSpaceTableViewCell.h"
#import "LCRechargeMainVC.h"
#import "LCExchangeMainVC.h"
#import "LCWithdrawMainVC.h"
@interface LCWalletMainVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) LCWalletHeaderView *headerView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@end

@implementation LCWalletMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钱包";
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self addNavigationBackButton];
    [self initializeMainView];
    [self addNotificationWithSelector:@selector(updateUserMessage) name:kWallet_Change_Notice];
    
}
- (void)updateUserMessage {
    [self.headerView setupMoney:kUserMessageManager.sMoney];
    [self.mainTableView reloadData];
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
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 4) {
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else if (indexPath.row == 0) {
        LCWalletIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCWalletIconTableViewCell];
        return cell;
    }else if (indexPath.row == 5){
        LCWalletTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCWalletTitleTableViewCell];
        return cell;
    }else {
        LCWalletMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCWalletMoneyTableViewCell];
        NSString *title = indexPath.row == 2? @"我的金币" : @"我的银币";
        NSString *detail = indexPath.row == 2? kUserMessageManager.money : kUserMessageManager.yMoney;
        [cell setupCellContentWithTitle:title money:detail];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 4) {
        return 10;
    }else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 5) {
        if (indexPath.row == 0) {
            LCRechargeMainVC *rechargeVC = [[LCRechargeMainVC alloc]init];
            rechargeVC.isChangeNavi = YES;
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }else {
            LCExchangeMainVC *exchangeVC = [[LCExchangeMainVC alloc]init];
            [self.navigationController pushViewController:exchangeVC animated:YES];
        }
    }
}
- (void)jumpWithdrawVC {
    LCWithdrawMainVC *withdrawVC = [[LCWithdrawMainVC alloc]init];
    [self.navigationController pushViewController:withdrawVC animated:YES];
}
#pragma makr -view
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCWalletIconTableViewCell bundle:nil] forCellReuseIdentifier:kLCWalletIconTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCWalletMoneyTableViewCell bundle:nil] forCellReuseIdentifier:kLCWalletMoneyTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCWalletTitleTableViewCell bundle:nil] forCellReuseIdentifier:kLCWalletTitleTableViewCell];
    [tableView registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    LCWalletHeaderView *header = [[LCWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    self.headerView = header;
    tableView.tableHeaderView = header;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    header.headerBlock = ^(NSInteger type) {
        [ws jumpWithdrawVC];
    };
     [self.headerView setupMoney:kUserMessageManager.sMoney];
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
