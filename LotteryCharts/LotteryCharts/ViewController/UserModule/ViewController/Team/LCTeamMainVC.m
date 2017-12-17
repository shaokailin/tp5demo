//
//  LCTeamMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamMainVC.h"
#import "LCTeamHeaderView.h"
#import "LCTeamTableViewCell.h"
#import "LSKImageManager.h"
#import "LCTeamViewModel.h"
#import "LCMySpaceMainVC.h"
@interface LCTeamMainVC ()
{
    NSInteger _showType;
    BOOL _isChange;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, weak) LCTeamHeaderView *headerView;
@property (nonatomic, strong) LCTeamViewModel *viewModel;
@end

@implementation LCTeamMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.title = @"我的团队";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        _isChange = NO;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isChange = YES;
}
- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorRGBA(0, 0, 0, 0.3) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCTeamViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.teamArray.count];
        }else if (identifier == 1){
            LCTeamCountModel *model1 = (LCTeamCountModel *)model;
            [self.headerView setupContentWithLineCount:model1.onlinecount allCount:model1.teamcount];
        }else {
            [self.headerView setupContentWithLineCount:@"0" allCount:model];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 0) {
            if (self.viewModel.page == 0) {
                [self.mainTableView reloadData];
            }
            [self endRefreshing];
        }else {
            [self.headerView setupContentWithLineCount:@"0" allCount:@"0"];
        }
    }];
    [_viewModel bindSinal];
    [self getMessage];
}
- (void)getMessage {
    _viewModel.page = 0;
    _viewModel.showType = _showType;
    [_viewModel getTeamList:NO];
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
    [_viewModel getTeamList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getTeamList:YES];
}
- (void)changeShowClick:(NSInteger)type {
    if (_showType != type) {
        _showType = type;
        [self getMessage];
    }
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.teamArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCTeamTableViewCell];
    LCTeamModel *model = [_viewModel.teamArray objectAtIndex:indexPath.row];
    [cell setupContentWithPhoto:model.logo name:model.nickname userId:model.uid glodCount:model.money yinbiCount:model.ymoney type:_showType state:_showType == 0? model.is_online : model.is_sign];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
    LCTeamModel *model = [_viewModel.teamArray objectAtIndex:indexPath.row];
    space.userId = model.uid;
    [self.navigationController pushViewController:space animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)initializeMainView {
    _showType = 0;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCTeamTableViewCell bundle:nil] forCellReuseIdentifier:kLCTeamTableViewCell];
    tableView.rowHeight = 80;
    LCTeamHeaderView *headerView = [[LCTeamHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 217)];
    self.headerView = headerView;
    tableView.tableHeaderView = headerView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
    }];
    headerView.teamBlock = ^(NSInteger type) {
        [ws changeShowClick:type];
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
