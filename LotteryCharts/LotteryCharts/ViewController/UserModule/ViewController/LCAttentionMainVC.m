//
//  LCAttentionMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCAttentionMainVC.h"
#import "LCAttentionTableViewCell.h"
@interface LCAttentionMainVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isChange;
}
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation LCAttentionMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的关注";
    [self backToNornalNavigationColor];
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    _isChange = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
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
    LCAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCAttentionTableViewCell];
    [cell setupContentWithPhoto:nil name:@"凯先生" userId:@"码师ID:123456" glodCount:@"12345" yinbiCount:@"12345.00"];
    return cell;
}
- (void)initializeMainView {
    
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCAttentionTableViewCell bundle:nil] forCellReuseIdentifier:kLCAttentionTableViewCell];
    mainTableView.rowHeight = 80;
   
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
