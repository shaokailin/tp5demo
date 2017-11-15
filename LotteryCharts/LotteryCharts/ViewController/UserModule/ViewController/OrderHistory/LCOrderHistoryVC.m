//
//  LCOrderHistoryVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCOrderHistoryVC.h"
#import "LCHistoryOrderTableViewCell.h"
#import "LCSearchBarView.h"
@interface LCOrderHistoryVC ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCSearchBarView *searchView;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHistoryOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHistoryOrderTableViewCell];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark 界面
- (void)initializeMainView {
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHistoryOrderTableViewCell bundle:nil] forCellReuseIdentifier:kLCHistoryOrderTableViewCell];
    mainTableView.rowHeight = 100;
    LCSearchBarView *searchView = [[LCSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.searchView = searchView;
    mainTableView.tableHeaderView = searchView;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
