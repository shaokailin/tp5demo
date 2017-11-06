//
//  PPSSOrderHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeVC.h"
#import "PPSSOrderHomeSearchView.h"
#import "PPSSOrderHomeTableViewCell.h"
#import "PPSSPiskSelectView.h"
#import "PPSSOrderHomeScreenView.h"
#import "PPSSOrderDetailVC.h"
#import "PPSSOrderHomeViewModel.h"
#import "PPSSOrderListModel.h"
#import "PPSSShopListModel.h"
@interface PPSSOrderHomeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    BOOL _isOrderListFirst;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSOrderHomeSearchView *searchView;
@property (nonatomic, strong) PPSSPiskSelectView *selectPickView;
@property (nonatomic, strong) PPSSOrderHomeViewModel *viewModel;
@property (nonatomic, strong) PPSSOrderHomeScreenView *screentView;
@end

@implementation PPSSOrderHomeVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isOrderListFirst) {
        _isOrderListFirst = YES;
        [self.viewModel getOrderList:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSOrderHomeViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
             [self showShopLists];
        }else {
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.orderListArray.count];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier != 0) {
            @strongify(self)
            [self.mainTableView reloadData];
            [self endRefreshing];
             [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.orderListArray.count];
        }
    }];
    _viewModel.dateString = self.searchView.dateString;
}
#pragma mark private
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getOrderList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getOrderList:YES];
    
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
//点击筛选事件
- (void)selectPayType {
    [self.screentView showInView];
}
- (PPSSOrderHomeScreenView *)screentView {
    if (!_screentView) {
        WS(ws)
        self.screentView = [[PPSSOrderHomeScreenView alloc]initWithEventBlock:^(NSInteger payType, NSInteger payState) {
            if (payType == ws.viewModel.payType && ws.viewModel.payStatus == payState) {
            }else {
                ws.viewModel.page = 0;
                ws.viewModel.payType = payType;
                ws.viewModel.payStatus = payState;
                [ws.viewModel getOrderList:NO];
            }
        } tabbarHeight:self.tabbarBetweenHeight];
    }
    return _screentView;
}
//点击头部的时间和门店的筛选
- (void)headerViewClickEventWithType:(OrderHomeSearchClickType)type {
    if (type == OrderHomeSearchClickType_Search) {
        self.viewModel.searchText = self.searchView.searchText;
        [self.viewModel getOrderList:NO];
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
- (void)showShopLists {
    self.selectPickView.titleText = @"选择门店";
    [self.selectPickView setPickViewSource:self.viewModel.shopListArray];
    self.selectPickView.type = PickViewType_Source;
    [self.selectPickView showInView];
}
//选择的回调
- (void)setupSelectTitle:(PickViewType)type content:(NSString *)content {
    if (type == PickViewType_Date) {
        [self.searchView changeBtnText:content type:OrderHomeSearchClickType_Date];
        if (![self.viewModel.dateString isEqualToString:content]) {
            self.viewModel.dateString = content;
            self.viewModel.page = 0;
            [self.viewModel getOrderList:NO];
        }
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
        [self.searchView changeBtnText:shopName type:OrderHomeSearchClickType_Shop];
        [self.viewModel getOrderList:NO];
    }
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel) {
        return self.viewModel.orderListArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderModel *model = [self.viewModel.orderListArray objectAtIndex:indexPath.row];
    PPSSOrderHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSOrderHomeTableViewCell];
    NSInteger type = [model.payState integerValue] == 2 ? -1 : [model.businessType integerValue];
    [cell setupCellContentWithName:model.userName timeString:model.businessTime money:model.businessFee type:type photoImage:model.avatar];
//    [cell setupCellContentWithTime:model.businessTime orderNum:model.orderNo money:model.businessFee type:type];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderModel *model = [self.viewModel.orderListArray objectAtIndex:indexPath.row];
//    if ([model.payState integerValue] == 1) {
        PPSSOrderDetailVC *detail = [[PPSSOrderDetailVC alloc]init];
        detail.orderNo = model.orderNo;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
//    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"筛选" target:self action:@selector(selectPayType)];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tableView.rowHeight = 75;
    [tableView registerClass:[PPSSOrderHomeTableViewCell class] forCellReuseIdentifier:kPPSSOrderHomeTableViewCell];
    PPSSOrderHomeSearchView *headerView = [[PPSSOrderHomeSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45 + 10 + 44)];
    WS(ws)
    headerView.clickBlock = ^(OrderHomeSearchClickType type) {
        [ws headerViewClickEventWithType:type];
    };
    self.searchView = headerView;
    tableView.tableHeaderView = headerView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
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
