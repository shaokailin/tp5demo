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
#import "LCMySpaceMainVC.h"
#import "LCSearchPostVC.h"
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
        }else if (identifier == 50) {
            LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
            space.userId = model;
            space.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:space animated:YES];
        }else if (identifier == 60) {
            LCSearchPostVC *search = [[LCSearchPostVC alloc]init];
            search.searchText = self.viewModel.searchText;
            search.searchArray = model;
            search.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:search animated:YES];
        }else if (identifier == 70){
            LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
            LCPostDetailModel *detaiModel = (LCPostDetailModel *)model;
            LCHomePostModel *postModel = [[LCHomePostModel alloc]init];
            postModel.post_id = detaiModel.post_id;
            postModel.post_title = detaiModel.post_title;
            postModel.post_content = detaiModel.post_content;
            postModel.post_upload = detaiModel.post_upload;
            postModel.post_type = detaiModel.post_type;
            postModel.post_money = detaiModel.post_money;
            postModel.post_vipmoney = detaiModel.post_vipmoney;
            postModel.user_id = detaiModel.user_id;
             postModel.nickname = detaiModel.nickname;
             postModel.logo = detaiModel.logo;
             postModel.reply_count = detaiModel.reply_count;
             postModel.reward_count = detaiModel.reward_count;
             postModel.reward_money = detaiModel.reward_money;
            postModel.make_click = detaiModel.make_click;
            postModel.status = detaiModel.status;
            postModel.create_time = detaiModel.create_time;
            detail.postModel = postModel;
            detail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detail animated:YES];
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
        if (![self isCanJumpViewForLogin:YES]) {
            return;
        }
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
            case 2:
            {
                LCWebViewController *webView  = [[LCWebViewController alloc]init];
                if (index == 1) {
                    webView.loadUrl = KLIVE_BROADCAST;
                    webView.titleString = @"直播";
                }else {
                    webView.loadUrl = KJIE_MENG;
                    webView.titleString = @"解梦";
                }
                controller = webView;
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
        if ([self isCanJumpViewForLogin:YES]) {
            self.viewModel.searchType = self.headerView.searchIndex;
            [self.viewModel searchPostEvent:actionParam];
        }
    }else {
        if (self.viewModel.messageModel && KJudgeIsArrayAndHasValue(self.viewModel.messageModel.period_list)) {
            LCHistoryLotteryVC *lottery = [[LCHistoryLotteryVC alloc]init];
            lottery.hidesBottomBarWhenPushed = YES;
            lottery.type = type;
//            if (self.viewModel.messageModel.period_list.count > 1) {
//                if (type == 6) {
//                    LC3DLotteryModel *model = [self.viewModel.messageModel.period_list objectAtIndex:1];
//                    lottery.searchText = model.period_id;
//                }
//            }
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
    [cell setupContentWithPhoto:model.logo name:model.nickname userId:model.mch_no postId:model.post_id time:model.create_time title:model.post_title showCount:model.make_click money:model.post_money];
    WS(ws)
    cell.photoBlock = ^(id clickCell) {
        [ws jumpSpaceView:clickCell];
    };
    return cell;
}
- (void)jumpSpaceView:(LCHomeHotPostTableViewCell *)cell {
    if ([self isCanJumpViewForLogin:YES]) {
        NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
        LCHomePostModel *model = [self.viewModel.hotPostArray objectAtIndex:indexPath.row];
        LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
        space.userId = model.user_id;
        space.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:space animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCanJumpViewForLogin:YES]) {
        LCHomePostModel *model = [self.viewModel.hotPostArray objectAtIndex:indexPath.row];
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        detail.postModel = model;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
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
    
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kLineMain_Color, 1.0) backgroundColor:nil];
    LCHomeHeaderView *headerView = [[LCHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 486)];
    self.headerView = headerView;
    
    mainTableView.tableHeaderView = headerView;
    
    [mainTableView registerNib:[UINib nibWithNibName:kLCHomeHotPostTableViewCell bundle:nil] forCellReuseIdentifier:kLCHomeHotPostTableViewCell];
    mainTableView.rowHeight = 68;
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
