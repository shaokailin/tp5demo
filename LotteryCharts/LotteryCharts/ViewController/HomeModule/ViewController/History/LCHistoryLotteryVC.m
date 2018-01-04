//
//  LCHistoryLotteryVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryLotteryVC.h"
#import "LCHistoryLotteryTableViewCell.h"
#import "LCOderSearchBarView.h"
#import "PopoverView.h"
#import "LCHistoryLotteryViewModel.h"
@interface LCHistoryLotteryVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger _searchType;
}
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCOderSearchBarView *searchView;
@property (nonatomic, strong) LCHistoryLotteryViewModel *viewModel;

@end

@implementation LCHistoryLotteryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"开奖历史";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
    
}

- (void)searchClick:(NSString *)text {
    [self.view endEditing:YES];
    self.viewModel.period_id = text;
    self.viewModel.limitRow = _searchType;
    [self.viewModel getHistoryLotteryList:NO];
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
        [self.searchView setupContent:title];
        self.viewModel.page = 0;
        [self.viewModel getHistoryLotteryList:NO];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCHistoryLotteryViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
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
    if (KJudgeIsNullData(self.searchText)) {
        self.searchView.searchText = self.searchText;
        [self searchClick:self.searchText];
    }else{
        [self.viewModel getHistoryLotteryList:NO];
    }
    
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
    [_viewModel getHistoryLotteryList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getHistoryLotteryList:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.historyArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHistoryLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryLotteryTableViewCell];
    LC3DLotteryModel *model = [self.viewModel.historyArray objectAtIndex:indexPath.row];
    
    [cell setupContentWithTime:model.betting_time issue:model.period_id testRun:model.test_number number1:model.number1 number2:model.number2 number4:@"8" number3:model.number3 number5:@"8" type:self.type];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark 界面
- (NSArray *)menuArray {
    if (!_menuArray) {
        WS(ws)
        PopoverAction *multichatAction = [PopoverAction actionWithImage:nil title:@"全部" handler:^(PopoverAction *action) {
            [ws searchEnumClick:0 title:action.title];
        }];
        PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"近5期" handler:^(PopoverAction *action) {
            [ws searchEnumClick:1 title:action.title];
        }];
        _menuArray = [NSArray arrayWithObjects:multichatAction,addFriAction, nil];
    }
    return _menuArray;
}
- (void)initializeMainView {
    _searchType = 0;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryLotteryTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryLotteryTableViewCell];
    mainTableView.rowHeight = 75;
    LCOderSearchBarView *searchView = [[LCOderSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.searchView = searchView;
    [searchView setupSearchType:1];
    [searchView setupContent:@"全部"];
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
