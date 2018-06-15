//
//  LCSearchPostVC.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSearchPostVC.h"
#import "LCSearchPostViewModel.h"
#import "LCHomeHotPostTableViewCell.h"
#import "LCPostDetailVC.h"
@interface LCSearchPostVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCSearchPostViewModel *viewModel;
@end

@implementation LCSearchPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索结果";
    [self bindSignal];
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCSearchPostViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.searchArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self endRefreshing];
    }];
    _viewModel.searchText = self.searchText;
    _viewModel.page = 0;
    [_viewModel.searchArray addObjectsFromArray:self.searchArray];
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
    [_viewModel getSearchResult];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getSearchResult];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.searchArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHomeHotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHomeHotPostTableViewCell];
    LCHomePostModel *model = [self.viewModel.searchArray objectAtIndex:indexPath.row];
    [cell setupContentWithPhoto:model.logo name:model.nickname userId:model.user_id postId:model.post_id time:model.create_time title:model.post_title showCount:model.make_click money:model.post_money funs:KNullTransformNumber(model.fans_count)comtent:model.reply_count];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCanJumpViewForLogin:YES]) {
        LCHomePostModel *model = [self.viewModel.searchArray objectAtIndex:indexPath.row];
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        detail.postModel = model;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)initializeMainView {
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCHomeHotPostTableViewCell bundle:nil] forCellReuseIdentifier:kLCHomeHotPostTableViewCell];
    mainTableView.rowHeight = 80;
    mainTableView.tableFooterView = [[UIView alloc]init];
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
