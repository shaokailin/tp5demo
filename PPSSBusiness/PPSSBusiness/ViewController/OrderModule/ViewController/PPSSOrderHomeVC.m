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
@interface PPSSOrderHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSOrderHomeSearchView *searchView;
@property (nonatomic, strong) PPSSPiskSelectView *selectPickView;
@end

@implementation PPSSOrderHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark private
- (void)selectPayType {
    PPSSOrderHomeScreenView *screentView = [[PPSSOrderHomeScreenView alloc]initWithEventBlock:^(NSInteger payType, NSInteger payState) {
        
    }];
    [screentView showInView];
}
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
        [self.searchView changeBtnText:content type:OrderHomeSearchClickType_Date];
    }else {
        [self.searchView changeBtnText:@"全部门店" type:OrderHomeSearchClickType_Shop];
    }
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSOrderHomeTableViewCell];
    [cell setupCellContentWithTime:@"2017-09-18 12:12:12" orderNum:@"23123123123123123231" money:@"41905.00" type:indexPath.row % 5];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderDetailVC *detail = [[PPSSOrderDetailVC alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"筛选" target:self action:@selector(selectPayType)];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tableView.rowHeight = 61;
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
