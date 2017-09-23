//
//  PPSSWithdrawApplyVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWithdrawApplyVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "PPSSWithdrawHeaderView.h"
#import "PPSSWithdrawListTableViewCell.h"
@interface PPSSWithdrawApplyVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, weak) PPSSWithdrawHeaderView *headerView;
@end

@implementation PPSSWithdrawApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kWithdrawApply_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark action
- (void)pullUpLoadMore {
    
}
- (void)pullDownRefresh {
    
}
- (void)withdrawApplyMoney:(NSString *)money {
    
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSWithdrawListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSWithdrawListTableViewCell];
    [cell setupContentWithTime:@"2017-10-12/2019-10-13" money:@"1000.00" type:indexPath.row % 3];
    return cell;
}

#pragma mark - init
- (void)initializeMainView {
    TPKeyboardAvoidingTableView *tablView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tablView registerClass:[PPSSWithdrawListTableViewCell class] forCellReuseIdentifier:kPPSSWithdrawListTableViewCell];
    tablView.rowHeight = 60;
    PPSSWithdrawHeaderView *headerView = [[PPSSWithdrawHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220 + 44)];
    WS(ws)
    headerView.withdrawBlock = ^(NSString *money) {
        [ws withdrawApplyMoney:money];
    };
    self.headerView = headerView;
    tablView.tableHeaderView = headerView;
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
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
