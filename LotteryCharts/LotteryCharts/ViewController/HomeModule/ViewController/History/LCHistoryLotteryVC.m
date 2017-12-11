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
    self.title = @"历史订单";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)searchClick {
    [self.view endEditing:YES];
}
- (void)headerViewEvent:(NSInteger)type param:(id)param {
    if (type == 0) {
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
        popoverView.showShade = YES;
        popoverView.selectIndex = _searchType;
        [popoverView showToView:param withActions:self.menuArray];
    }else {
        
    }
}
- (void)searchEnumClick:(NSInteger)type title:(NSString *)title {
    if (type != _searchType) {
        _searchType = type;
        [self.searchView setupContent:title];
    }
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHistoryLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryLotteryTableViewCell];
    [cell setupContentWithTime:@"2017年10月23日  星期日" issue:@"20171023" testRun:@"312" number1:@"3" number2:@"1" number3:@"2"];
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
