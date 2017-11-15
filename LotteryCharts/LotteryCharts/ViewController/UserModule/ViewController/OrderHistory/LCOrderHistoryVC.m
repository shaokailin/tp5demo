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
@interface LCOrderHistoryVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger _searchType;
}
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCOderSearchBarView *searchView;
@end

@implementation LCOrderHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史订单";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self backToNornalNavigationColor];
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
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHistoryOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryOrderTableViewCell];
    [cell setupContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日发布" photoImage:nil name:@"凯先生" userId:@"码师ID:123456" detail:@"详情摘要详情摘要" money:@"100"];
    return cell;
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
        PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"打赏记录" handler:^(PopoverAction *action) {
            [ws searchEnumClick:1 title:action.title];
        }];
        PopoverAction *add1FriAction = [PopoverAction actionWithImage:nil title:@"竞猜参与记录" handler:^(PopoverAction *action) {
            [ws searchEnumClick:2 title:action.title];
        }];
        PopoverAction *add2FriAction = [PopoverAction actionWithImage:nil title:@"VIP订单" handler:^(PopoverAction *action) {
            [ws searchEnumClick:3 title:action.title];
        }];
        _menuArray = [NSArray arrayWithObjects:multichatAction,addFriAction,add1FriAction,add2FriAction, nil];
    }
    return _menuArray;
}
- (void)initializeMainView {
    _searchType = 0;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryOrderTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryOrderTableViewCell];
    mainTableView.rowHeight = 100;
    LCOderSearchBarView *searchView = [[LCOderSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchView = searchView;
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
