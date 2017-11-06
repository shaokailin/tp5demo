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
#import "PPSSWithdrawApplyViewModel.h"
@interface PPSSWithdrawApplyVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, weak) PPSSWithdrawHeaderView *headerView;
@property (nonatomic, strong) PPSSWithdrawApplyViewModel *viewModel;
@end

@implementation PPSSWithdrawApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kWithdrawApply_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark action
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSWithdrawApplyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self.headerView setupMoneyViewWithBalance:self.viewModel.totalMoney share:nil];
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.withdrawListArray.count];
        }else {
            if (self.viewModel.totalMoney) {
                NSDecimalNumber*number1 = [NSDecimalNumber decimalNumberWithString:self.viewModel.totalMoney];
                NSDecimalNumber*number2 = [NSDecimalNumber decimalNumberWithString:self.viewModel.withdrawMoney];
                NSDecimalNumber*jianfa= [number1 decimalNumberBySubtracting:number2];
                self.viewModel.totalMoney = jianfa.stringValue;
                [self.headerView setupMoneyViewWithBalance:self.viewModel.totalMoney share:nil];
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier == 0) {
            @strongify(self)
            [self endRefreshing];
        }
    }];
    [self.viewModel getWithdrawList:NO];
}
- (void)pullUpLoadMore {
    self.viewModel.page += 1;
    [self.viewModel getWithdrawList:YES];
}
- (void)pullDownRefresh {
    self.viewModel.page = 0;
    [self.viewModel getWithdrawList:YES];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
#pragma mark -申请
- (void)withdrawApplyMoney:(NSString *)money {
    [self.view endEditing:YES];
    if (KJudgeIsNullData(money) && [money floatValue] >= 10) {
        if (self.viewModel.totalMoney && [self.viewModel.totalMoney floatValue] < [money floatValue]) {
            [SKHUD showMessageInView:self.view withMessage:@"提现金额不能大于商户余额~!"];
            return;
        }
        self.viewModel.withdrawMoney = money;
        [self.viewModel withdrawApplyEvent];
    }else {
        [SKHUD showMessageInView:self.view withMessage:@"提现金额需要"];
    }
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel && self.viewModel.withdrawListArray) {
        return self.viewModel.withdrawListArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSWithdrawListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSWithdrawListTableViewCell];
    PPSSWithdrawModel *model = [self.viewModel.withdrawListArray objectAtIndex:indexPath.row];
    [cell setupContentWithTime:model.time money:model.amount type:[model.state integerValue]];
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
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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
