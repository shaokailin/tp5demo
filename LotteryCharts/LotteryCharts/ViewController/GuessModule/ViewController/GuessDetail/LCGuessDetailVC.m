//
//  LCGuessDetailVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessDetailVC.h"
#import "LCPostHeaderTableViewCell.h"
#import "LCPostCommentTableViewCell.h"
#import "LCCommentInputView.h"
#import "LCGuessHeaderView.h"
@interface LCGuessDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCGuessHeaderView *headerView;
@end

@implementation LCGuessDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"猜大小";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)showRule {
    [self.view endEditing:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCPostHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostHeaderTableViewCell];
        [cell setupCount:@"10" type:0];
        return cell;
    }else {
        LCPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostCommentTableViewCell];
        [cell setupPhoto:nil name:@"凯先生" userId:@"码师ID:123456" index:indexPath.row time:@"10月10日  12:23" content:@"内容内容"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }else {
        return 60;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing: YES];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"规则" target:self action:@selector(showRule)];
    LCCommentInputView *inputView = [[LCCommentInputView alloc]init];
    [self.view addSubview:inputView];
    WS(ws)
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
    }];
    
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCPostCommentTableViewCell bundle:nil] forCellReuseIdentifier:kLCPostCommentTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCPostHeaderTableViewCell bundle:nil] forCellReuseIdentifier:kLCPostHeaderTableViewCell];
    LCGuessHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LCGuessHeaderView" owner:self options:nil] lastObject];
    self.headerView = headerView;
    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 272)];
    [headerBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(headerBgView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [headerView setupContentTitle:@"挑战主题" money:@"1000" count:@"8" number1:@"1" number2:@"2" type:self.type];
    mainTableView.tableHeaderView = headerBgView;
    
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(inputView.mas_top);
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
