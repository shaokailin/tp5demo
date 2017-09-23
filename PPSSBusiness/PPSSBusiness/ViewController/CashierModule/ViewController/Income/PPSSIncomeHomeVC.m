//
//  PPSSIncomeHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeHomeVC.h"
#import "PPSSIncomeHeaderView.h"
#import "PPSSIncomeMoneyTableViewCell.h"
#import "PPSSIncomeMessageTableViewCell.h"
#import "PPSSIncomeFooterView.h"
#import "PPSSPiskSelectView.h"
@interface PPSSIncomeHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) PPSSIncomeHeaderView *headerView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) PPSSPiskSelectView *selectPickView;
@end

@implementation PPSSIncomeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kIncome_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark - action

#pragma mark header
- (void)headerViewClickEventWithType:(OrderHomeSearchClickType)type {
    if (type == OrderHomeSearchClickType_Search) {
        
    }else if (type == OrderHomeSearchClickType_Date) {
        self.selectPickView.type = PickViewType_Date;
        self.selectPickView.titleText = @"选择时间";
        [self.selectPickView showInView];
    }else {
        self.selectPickView.titleText = @"选择门店";
        [self.selectPickView setPickViewSource:@[@"选择门店",@"选择门店",@"选择门店",@"选择门店",@"选择门店"]];
        self.selectPickView.type = PickViewType_Source;
        [self.selectPickView showInView];
    }
}
- (PPSSPiskSelectView *)selectPickView {
    if (!_selectPickView) {
        _selectPickView = [[PPSSPiskSelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        @weakify(self)
        _selectPickView.pickBlock = ^(PickViewType type, NSString *content) {
            @strongify(self)
            [self setupSelectTitle:type content:content];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_selectPickView];
    }
    return _selectPickView;
}
- (void)setupSelectTitle:(PickViewType)type content:(NSString *)content {
    if (type == PickViewType_Date) {
        [self.headerView changeBtnText:content type:OrderHomeSearchClickType_Date];
    }else {
        [self.headerView changeBtnText:@"全部门店" type:OrderHomeSearchClickType_Shop];
    }
}
#pragma mark -delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PPSSIncomeMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSIncomeMoneyTableViewCell];
        [cell setupContentWithMoney:@"43232.00"];
        return cell;
    }else {
        PPSSIncomeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSIncomeMessageTableViewCell];
        [cell setupContentWithLeft:[self returnLeftTitle:indexPath.row] right:@"￥1231"];
        return cell;
    }
}
- (NSString *)returnLeftTitle:(NSInteger)index {
    NSString *leftString = nil;
    switch (index - 1) {
        case 0:
        {
            leftString = @"总收款";
            break;
        }
        case 1:
        {
            leftString = @"活动优惠";
            break;
        }
        case 2:
        {
            leftString = @"手续费";
            break;
        }
        default:
            break;
    }
    return leftString;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    }
    return 44;
}
#pragma mark - init
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSIncomeMoneyTableViewCell class] forCellReuseIdentifier:kPPSSIncomeMoneyTableViewCell];
    [tableView registerClass:[PPSSIncomeMessageTableViewCell class] forCellReuseIdentifier:kPPSSIncomeMessageTableViewCell];
    PPSSIncomeHeaderView *headerView = [[PPSSIncomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    WS(ws)
    headerView.clickBlock = ^(OrderHomeSearchClickType type) {
        [ws headerViewClickEventWithType:type];
    };
    self.headerView = headerView;
    tableView.tableHeaderView = headerView;
    
    PPSSIncomeFooterView *footerView = [[PPSSIncomeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    footerView.footerBlock = ^(NSInteger type) {
        
    };
    tableView.tableFooterView = footerView;
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
