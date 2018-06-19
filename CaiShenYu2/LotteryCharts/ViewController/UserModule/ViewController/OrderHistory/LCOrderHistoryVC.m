//
//  LCOrderHistoryVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCOrderHistoryVC.h"
#import "LCHistoryOrderTableViewCell.h"
#import "LCOderSearchBarView.h"
#import "PopoverView.h"
#import "LCHistoryOrderViewModel.h"
#import "LCHistoryGuessTableViewCell.h"
#import "LCHistoryVipTableViewCell.h"
#import "LCMySpaceMainVC.h"
#import "LCPostDetailVC.h"
#import "LCGuessDetailVC.h"

@interface LCOrderHistoryVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger _searchType;
    BOOL _isChange;
}
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCOderSearchBarView *searchView;
@property (nonatomic, strong) LCHistoryOrderViewModel *viewModel;
@end

@implementation LCOrderHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史订单";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self backToNornalNavigationColor];
    [self bindSignal];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}

- (void)searchClick:(NSString *)str {
    [self.view endEditing:YES];
    self.viewModel.period_id = str;
    [self.viewModel getHistoryOrderList:NO];
}

- (void)headerViewEvent:(NSInteger)type param:(id)param {
    if (type == 0) {
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
        popoverView.showShade = YES;
        popoverView.selectIndex = _searchType;
        [popoverView showToView:param withActions:self.menuArray];
    }else {
        [self searchClick:param];
    }
}
- (void)searchEnumClick:(NSInteger)type title:(NSString *)title {
    if (type != _searchType) {
        _searchType = type;
        self.viewModel.showType = _searchType;
        self.searchView.searchField.text = nil;
        self.viewModel.period_id = nil;
        [self.searchView setupContent:title];
        self.viewModel.page = 0;
        [self.viewModel getHistoryOrderList:NO];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCHistoryOrderViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.historyArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self.viewModel.page == 0) {
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    [self.viewModel getHistoryOrderList:NO];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getHistoryOrderList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getHistoryOrderList:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.historyArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_searchType == 0) {
        LCHistoryOrderModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCHistoryOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryOrderTableViewCell];
        [cell setupContentWithPostId:model.post_id pushTime:_viewModel.showType == 2?model.pay_time:model.create_time photoImage:model.logo name:model.nickname userId:model.mch_no detail:model.post_title money:model.award_money];
        WS(ws)
        cell.photoBlock = ^(id clickCell) {
            [ws photoClick:clickCell];
        };
        return cell;
    }else if (_searchType == 1){
        LCHistoryGuessModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCHistoryGuessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryGuessTableViewCell];
        [cell setupCellContent:model.quiz_id time:model.create_time type:model.quiz_type title:model.quiz_title payMoney:model.quiz_money hasBuy:model.betting_num betState:model.status];
        return cell;
    }else {
        LCHistoryOrderModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCHistoryVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryVipTableViewCell];
        [cell setupCellContent:model.post_id time:model.create_time title:model.post_title payMoney:model.post_vipmoney];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_searchType == 0) {
        LCHistoryOrderModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        LCHomePostModel *detalmodel = [[LCHomePostModel alloc] init];
        detalmodel.user_id = model.uid;
        detalmodel.post_type = model.post_type;
        detalmodel.post_id = model.post_id;
        detail.postModel = detalmodel;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
        
    } else if (_searchType == 1){
        
        LCGuessDetailVC *detail = [[LCGuessDetailVC alloc]init];
         LCHistoryGuessModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCGuessModel *detalmodel = [[LCGuessModel alloc] init];
        detalmodel.quiz_id = model.quiz_id;
//        detalmodel.period_id = model.period_id;
        detail.guessModel = detalmodel;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        LCHistoryOrderModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        LCHomePostModel *detalmodel = [[LCHomePostModel alloc] init];
        detalmodel.user_id = model.uid;
        detalmodel.post_type = model.post_type;
        detalmodel.post_id = model.post_id;
        detail.postModel = detalmodel;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}



- (void)photoClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LCHistoryOrderModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
    LCMySpaceMainVC *detail = [[LCMySpaceMainVC alloc]init];
    detail.userId = model.uid;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark 界面
- (NSArray *)menuArray {
    if (!_menuArray) {
        WS(ws)
        PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"打赏记录" handler:^(PopoverAction *action) {
            [ws searchEnumClick:0 title:action.title];
        }];
        PopoverAction *add1FriAction = [PopoverAction actionWithImage:nil title:@"擂台参与记录" handler:^(PopoverAction *action) {
            [ws searchEnumClick:1 title:action.title];
        }];
        PopoverAction *add2FriAction = [PopoverAction actionWithImage:nil title:@"VIP订单" handler:^(PopoverAction *action) {
            [ws searchEnumClick:2 title:action.title];
        }];
        _menuArray = [NSArray arrayWithObjects:addFriAction,add1FriAction,add2FriAction, nil];
    }
    return _menuArray;
}
- (void)initializeMainView {
    _searchType = 0;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryOrderTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryOrderTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryVipTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryVipTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryGuessTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryGuessTableViewCell];
    mainTableView.rowHeight = 100;
    LCOderSearchBarView *searchView = [[LCOderSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchView = searchView;
    [searchView setupContent:@"打赏记录"];
    mainTableView.tableHeaderView = searchView;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    
    searchView.searchBlock = ^(NSInteger type, id param) {
        [ws headerViewEvent:type param:param];
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
