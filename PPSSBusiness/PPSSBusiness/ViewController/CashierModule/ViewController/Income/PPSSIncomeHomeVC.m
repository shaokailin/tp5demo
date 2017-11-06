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
#import "PPSSIncomeViewModel.h"
#import "PPSSShopListModel.h"
#import "PPSSWebVC.h"
@interface PPSSIncomeHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) PPSSIncomeHeaderView *headerView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) PPSSPiskSelectView *selectPickView;
@property (nonatomic, strong) PPSSIncomeViewModel *viewModel;
@end

@implementation PPSSIncomeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kIncome_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark - action
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSIncomeViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self showShopLists];
        }else {
            [self.mainTableView reloadData];
            [self.mainTableView.mj_header endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 1) {
            [self.mainTableView.mj_header endRefreshing];
        }
    }];
    _viewModel.timeDate = self.headerView.dateTime;
    [_viewModel getShopIncomeEvent:NO];
}
- (void)showShopLists {
    self.selectPickView.titleText = @"选择门店";
    [self.selectPickView setPickViewSource:self.viewModel.shopListArray];
    self.selectPickView.type = PickViewType_Source;
    [self.selectPickView showInView];
}
- (void)pullDownRefresh {
    [_viewModel getShopIncomeEvent:YES];
}
#pragma mark header
- (void)headerViewClickEventWithType:(OrderHomeSearchClickType)type {
    if (type == OrderHomeSearchClickType_Search) {
        
    }else if (type == OrderHomeSearchClickType_Date) {
        self.selectPickView.type = PickViewType_Date;
        self.selectPickView.titleText = @"选择时间";
        [self.selectPickView showInView];
    }else {
        if (![self.viewModel getShopList]) {
            [self showShopLists];
        }
    }
}

- (void)setupSelectTitle:(PickViewType)type content:(NSString *)content {
    if (type == PickViewType_Date) {
        [self.headerView changeBtnText:content type:OrderHomeSearchClickType_Date];
        self.viewModel.timeDate = content;
        [self.viewModel getShopIncomeEvent:NO];
    }else {
        NSString *shopName = nil;
        NSInteger index = [content integerValue];
        if (index == 0) {
            shopName = @"全部门店";
            self.viewModel.shopId = nil;
        }else {
            PPSSShopModel *model = [self.viewModel.shopListArray objectAtIndex:index - 1];
            shopName = model.shopName;
            self.viewModel.shopId = model.shopId;
        }
        [self.headerView changeBtnText:shopName type:OrderHomeSearchClickType_Shop];
        [self.viewModel getShopIncomeEvent:NO];
    }
}
#pragma mark -delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PPSSIncomeMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSIncomeMoneyTableViewCell];
        if (self.viewModel && self.viewModel.incomeModel) {
            [cell setupContentWithMoney:self.viewModel.incomeModel.bankFee];
        }
        return cell;
    }else if (indexPath.row == 4 || indexPath.row == 7){
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    } else {
        PPSSIncomeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSIncomeMessageTableViewCell];
        NSInteger titleType = (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 8) ? 0:1;
        NSInteger moneyType = indexPath.row < 4 ? 0:1;
        [cell setupContentWithLeft:[self returnLeftTitle:indexPath.row] right:[self returnRightValue:indexPath.row] titleType:titleType moneyType:moneyType];
        return cell;
    }
}
- (NSString *)returnRightValue:(NSInteger)index {
    if (self.viewModel && self.viewModel.incomeModel) {
        NSString *valueString = nil;
        switch (index - 1) {
            case 1:
            {
                valueString = self.viewModel.incomeModel.wxinFee;
                break;
            }
            case 2:
            {
                valueString = self.viewModel.incomeModel.aliFee;
                break;
            }
            
            case 4:
            {
                valueString = NSStringFormat(@"￥%@",self.viewModel.incomeModel.bankFee);
                break;
            }
            case 5:
            {
                valueString = self.viewModel.incomeModel.hsFee;
                break;
            }
            case 7:
            {
                valueString = self.viewModel.incomeModel.totalFee;
                break;
            }
            case 8:
            {
                valueString = self.viewModel.incomeModel.promotionFee;
                break;
            }
            default:
                break;
        }
        return valueString;
    }
    return nil;
}
- (NSString *)returnLeftTitle:(NSInteger)index {
    NSString *leftString = nil;
    switch (index - 1) {
        case 0:
        {
            leftString = @"收入明细";
            break;
        }
        case 1:
        {
            leftString = @"微信支付";
            break;
        }
        case 2:
        {
            leftString = @"支付宝支付";
            break;
        }
        case 4:
        {
            leftString = @"银行入账(元)";
            break;
        }
        case 5:
        {
            leftString = @"平台余额支付(可平台提现)";
            break;
        }
        case 7:
        {
            leftString = @"总收款";
            break;
        }
        case 8:
        {
            leftString = @"本店现金券";
            break;
        }
        default:
            break;
    }
    return leftString;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 75;
    }
    if (indexPath.row == 4 || indexPath.row == 7) {
        return 10;
    }
    return 50;
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
    
//    PPSSIncomeFooterView *footerView = [[PPSSIncomeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    @weakify(self)
//    footerView.footerBlock = ^(NSInteger type) {
//        @strongify(self)
//        PPSSWebVC *webVC = [[PPSSWebVC alloc]init];
//        webVC.title = @"关于手续费";
//        webVC.loadUrl = kPoundageWebUrl;
//        [self.navigationController pushViewController:webVC animated:YES];
//    };
//    tableView.tableFooterView = footerView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
}
- (PPSSPiskSelectView *)selectPickView {
    if (!_selectPickView) {
        _selectPickView = [[PPSSPiskSelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbarHeight:self.tabbarBetweenHeight];
        @weakify(self)
        _selectPickView.pickBlock = ^(PickViewType type, NSString *content) {
            @strongify(self)
            [self setupSelectTitle:type content:content];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_selectPickView];
    }
    return _selectPickView;
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
