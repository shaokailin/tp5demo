//
//  LCHomeMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeMainVC.h"
#import "LCHomeHeaderView.h"
#import "LCHomeHotPostTableViewCell.h"
#import "PopoverView.h"
#import "LCRechargeMainVC.h"
#import "LCLoginMainVC.h"
#import "LCRankingMainVC.h"
#import "LCHistoryLotteryVC.h"
#import "LCPushPostMainVC.h"
#import "LCPostDetailVC.h"
#import "LCHomeMainViewModel.h"
#import "LCWebViewController.h"
@interface LCHomeMainVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCHomeHeaderView *headerView;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) LCHomeMainViewModel *viewModel;
@end

@implementation LCHomeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark private
- (void)showMeunView:(UIButton *)sender {
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
    popoverView.showShade = YES;
    [popoverView showToView:sender withActions:[self neumActions]];
}
- (void)searchEnumClick:(NSInteger)index {
    self.headerView.searchIndex = index;
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCHomeMainViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.hotPostArray.count];
        }else if(identifier == 10){
            [self.headerView setupHotLineCount:model];
        }else {
            [self.headerView setupBannerData:self.viewModel.messageModel.adv_list];
            [self.headerView setupNotice:self.viewModel.messageModel.notice];
            [self.headerView setup3DMessage:self.viewModel.messageModel.period_list];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier == 0) {
            if (self.viewModel.page == 0) {
                [self.mainTableView reloadData];
            }
            [self endRefreshing];
        }
    }];
    [_viewModel bindSinal];
    [_viewModel getHomeMessage:NO];
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
    [_viewModel getHomeMessage:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getHomeMessage:YES];
}
- (void)headerViewActionType:(NSInteger)type actionParam:(id)actionParam {
    [self.view endEditing:YES];
    if (type == 1) {
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
        popoverView.showShade = YES;
        popoverView.selectIndex = self.headerView.searchIndex;
        [popoverView showToView:actionParam withActions:self.searchArray];
    }else if(type == 4) {
        NSInteger index = [actionParam integerValue];
        UIViewController *controller = nil;
        switch (index) {
            case 0:
            {
                LCRankingMainVC *ranking = [[LCRankingMainVC alloc]init];
                controller = ranking;
                break;
            }
            case 1:
            {
                if ([self isCanJumpViewForLogin:YES]) {
                    
                }
                break;
            }
            case 2:
            {
                LCHistoryLotteryVC *lottery = [[LCHistoryLotteryVC alloc]init];
                controller = lottery;
                break;
            }
            case 3:
            {
                LCRechargeMainVC *recgarge = [[LCRechargeMainVC alloc]init];
                controller = recgarge;
                break;
            }
            default:
                break;
        }
        if (controller) {
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else if (type == 3) {
        if (self.viewModel.messageModel && KJudgeIsArrayAndHasValue(self.viewModel.messageModel.adv_list)) {
            NSInteger index = [actionParam integerValue];
            if (index < self.viewModel.messageModel.adv_list.count) {
                LCAdBannerModel *banner = [self.viewModel.messageModel.adv_list objectAtIndex:index];
                if (KJudgeIsNullData(banner.url)) {
                    LCWebViewController *webVC = [[LCWebViewController alloc]init];
                    webVC.hidesBottomBarWhenPushed = YES;
                    webVC.loadUrl = banner.url;
                    webVC.titleString = banner.name;
                    [self.navigationController pushViewController:webVC animated:YES];
                }
            }
        }
    }else if (type == 2){//搜索
        
    }else {
        if (self.viewModel.messageModel && KJudgeIsArrayAndHasValue(self.viewModel.messageModel.period_list)) {
            LCHistoryLotteryVC *lottery = [[LCHistoryLotteryVC alloc]init];
            lottery.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lottery animated:YES];
        }
    }
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.hotPostArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHomeHotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHomeHotPostTableViewCell];
    LCHomePostModel *model = [self.viewModel.hotPostArray objectAtIndex:indexPath.row];
    [cell setupContentWithPhoto:model.logo name:model.nickname userId:model.user_id postId:model.post_id time:model.create_time title:model.post_title showCount:model.make_click money:model.post_money];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"支付金币查看内容" message:@"\n\n\n是否支付10金币查看该帖\n" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
    @weakify(self)
    [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        if ([x integerValue] == 1) {
            @strongify(self)
            LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
            detail.type = indexPath.row % 2;
            detail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail animated:YES];
        }
    }];
    [alterView show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -界面初始化
- (NSArray *)searchArray {
    if (!_searchArray) {
        WS(ws)
        PopoverAction *multichatAction = [PopoverAction actionWithImage:nil title:@"标题" handler:^(PopoverAction *action) {
            [ws searchEnumClick:0];
        }];
        PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"码师ID" handler:^(PopoverAction *action) {
            [ws searchEnumClick:1];
        }];
        PopoverAction *add1FriAction = [PopoverAction actionWithImage:nil title:@"帖子ID" handler:^(PopoverAction *action) {
            [ws searchEnumClick:2];
        }];
        _searchArray = [NSArray arrayWithObjects:multichatAction,addFriAction,add1FriAction, nil];
    }
    return _searchArray;
}
- (NSArray<PopoverAction *> *)neumActions {
    @weakify(self)
    PopoverAction *multichatAction = [PopoverAction actionWithImage:nil title:@"发帖" handler:^(PopoverAction *action) {
        @strongify(self)
        LCPushPostMainVC *postMainVcC = [[LCPushPostMainVC alloc]init];
        postMainVcC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:postMainVcC animated:YES];
    }];
    PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"充值" handler:^(PopoverAction *action) {
        @strongify(self)
        LCRechargeMainVC *recgarge = [[LCRechargeMainVC alloc]init];
        recgarge.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recgarge animated:YES]; 
    }];
    return @[multichatAction, addFriAction];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView:)];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    LCHomeHeaderView *headerView = [[LCHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 486)];
    self.headerView = headerView;
    
    mainTableView.tableHeaderView = headerView;
    
    [mainTableView registerNib:[UINib nibWithNibName:kLCHomeHotPostTableViewCell bundle:nil] forCellReuseIdentifier:kLCHomeHotPostTableViewCell];
    mainTableView.rowHeight = 80;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainTableView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(486);
    }];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    headerView.headerBlock = ^(NSInteger type, id actionParam) {
        [ws headerViewActionType:type actionParam:actionParam];
    };
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
