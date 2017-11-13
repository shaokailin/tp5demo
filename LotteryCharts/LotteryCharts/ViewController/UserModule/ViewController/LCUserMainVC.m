//
//  LCUserMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMainVC.h"
#import "LCUserHomeTableViewCell.h"
#import "LCUserHomeHeaderView.h"
#import "LCSpaceTableViewCell.h"
#import "LSKImageManager.h"
static NSString * const kSettingName = @"UserHomeSetting";
@interface LCUserMainVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_settingArray;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCUserHomeHeaderView *headerView;
@end

@implementation LCUserMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[LSKImageManager imageWithColor:ColorRGBA(0, 0, 0, 0.5) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)] forBarMetrics:UIBarMetricsDefault];
    [self initializeMainView];
}
- (void)loginOutClick {
    
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _settingArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 10) {
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else {
        LCUserHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCUserHomeTableViewCell];
        NSDictionary *dict = [_settingArray objectAtIndex:indexPath.row];
        [cell setupContentTitle:[dict objectForKey:@"title"] detail:[dict objectForKey:@"detail"] icon:[dict objectForKey:@"icon"]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 10) {
        return 10;
    }else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 10) {
    }else {
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark view
- (void)initializeMainView {
    _settingArray = [NSArray arrayWithPlist:kSettingName];
    
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [tableView registerNib:[UINib nibWithNibName:kLCUserHomeTableViewCell bundle:nil] forCellReuseIdentifier:kLCUserHomeTableViewCell];
    [tableView registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    LCUserHomeHeaderView *headerView = [[LCUserHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 304)];
    self.headerView = headerView;
    tableView.tableHeaderView = headerView;
    WS(ws)
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 88);
    UIButton *outBtn = [LSKViewFactory initializeButtonWithTitle:@"退出登录" target:self action:@selector(loginOutClick) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    outBtn.backgroundColor = [UIColor whiteColor];
    outBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [footView addSubview:outBtn];
    tableView.tableFooterView = footView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    
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
