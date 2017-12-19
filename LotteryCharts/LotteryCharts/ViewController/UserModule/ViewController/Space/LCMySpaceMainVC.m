//
//  LCMySpaceMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCMySpaceMainVC.h"
#import "LCUserHomeHeaderView.h"
#import "LSKImageManager.h"
#import "LCMySpaceTabView.h"
#import "LCRewardOrderTableViewCell.h"
#import "LCRewardRecordTableViewCell.h"
#import "LCRewardOrderHeaderTableViewCell.h"
#import "LCRewardRecordHeaderTableViewCell.h"
#import "LCSpacePostTableViewCell.h"
#import "LCSpaceGuessTableViewCell.h"
#import "LCSpaceHeaderTableViewCell.h"
#import "LCSpacePostVoiceTableViewCell.h"
#import "LCSpacePostVoiceImageTableViewCell.h"
#import "LCSpacePostTitleTableViewCell.h"
#import "LCSpaceMyOrderView.h"
#import "LCSpaceViewModel.h"
#import "LCAttentionMainVC.h"
#import "LCHomePostModel.h"
#import "LCPostDetailVC.h"
#import "LCGuessDetailVC.h"
@interface LCMySpaceMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isChange;
    NSInteger _showType;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCUserHomeHeaderView *headerView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) LCSpaceMyOrderView *orderView;
@property (nonatomic, strong) LCSpaceViewModel *viewModel;
@property (nonatomic, copy) NSString *moneyString;
@property (nonatomic, copy) NSString *countString;
@property (nonatomic, copy) NSString *my_mchmoney;
@property (nonatomic, copy) NSString *post_list_count;
@property (nonatomic, copy) NSString *quiz_count;
@property (nonatomic, assign) BOOL isCare;
@end

@implementation LCMySpaceMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.title = @"码师空间";
    [self addNavigationBackButton];
    self.moneyString = @"0.00";
    self.countString = @"0";
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isChange) {
        _isChange = YES;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
    }
}
- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorRGBA(0, 0, 0, 0.4) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isChange = NO;
    [self backToNornalNavigationColor];
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCSpaceViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 100) {
            
        }else {
            if (_showType == 0 && self.viewModel.page == 0) {
                LCSpacePostListModel *dataModel = (LCSpacePostListModel *)model;
                [self.headerView setupContentWithName:dataModel.user_info.nickname userid:dataModel.user_info.mchid attention:dataModel.follow_count teem:dataModel.team_count photo:dataModel.user_info.logo];
                self.post_list_count = dataModel.post_list_count;
                self.quiz_count = dataModel.quiz_count;
                self.my_mchmoney = dataModel.my_mchmoney;
                [self.headerView changeBgImage:dataModel.user_info.bglogo];
            }else if (_showType == 2 && self.viewModel.page == 0){
                LCSpaceSendRecordListModel *dataModel = (LCSpaceSendRecordListModel *)model;
                self.moneyString = dataModel.all_money;
                self.countString = dataModel.all_row;
            }
            [self.mainTableView reloadData];
            [self endRefreshing];
            [self showMyOrderMessage];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.dataArray.count];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 0) {
            if (self.viewModel.page == 0) {
                [self.mainTableView reloadData];
            }
            [self endRefreshing];
        }
    }];
    self.viewModel.uid = self.userId;
    self.viewModel.page = 0;
    self.viewModel.showType = _showType;
    [self.viewModel getSpaceData:NO];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)pullDownRefresh {
    self.viewModel.page = 0;
    [self.viewModel getSpaceData:YES];
}
- (void)pullUpLoadMore {
    self.viewModel.page += 1;
    [self.viewModel getSpaceData:YES];
}
- (void)headerViewClickEvent:(NSInteger)type {
    if (type == 4) {
        LCAttentionMainVC *attentionVC = [[LCAttentionMainVC alloc]init];
        attentionVC.userId = self.userId;
        [self.navigationController pushViewController:attentionVC animated:YES];
    }
}
- (void)showMeunView:(UIButton *)sender {
    
}
- (void)changeShowClick:(NSInteger)type {
    _showType = type;
    [self getDataMessage];
}
- (void)changeRewardShow:(NSInteger)type {
    if (type == 0) {
        _showType = 2;
    }else {
        _showType = 3;
    }
    [self getDataMessage];
}
- (void)getDataMessage {
    [self.viewModel.dataArray removeAllObjects];
    self.countString = @"0";
    [self.mainTableView reloadData];
    self.viewModel.page = 0;
    self.viewModel.showType = _showType;
    [self.viewModel getSpaceData:NO];
}
- (void)showMyOrderMessage {
    if (_showType == 2 && ![kUserMessageManager.userId isEqualToString:self.userId]) {
        self.orderView.hidden = NO;
        [_orderView setupContentWithIndex:nil photo:nil money:KNullTransformNumber(self.my_mchmoney)];
        WS(ws)
        [self.mainTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight - 49);
        }];
    }else if (_orderView && !_orderView.hidden) {
        _orderView.hidden = YES;
        WS(ws)
        [self.mainTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
        }];
    }
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel && _viewModel.dataArray.count > 0) {
        return _viewModel.dataArray.count + 1;
    }
    return  1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_showType == 0 || _showType == 1) {
            LCSpaceHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceHeaderTableViewCell];
            [cell setupCellContentWithCount:_showType == 0?self.post_list_count:self.quiz_count];
            return cell;
        }else if (_showType == 2) {
            LCRewardRecordHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordHeaderTableViewCell];
            WS(ws)
            cell.headerBlock = ^(NSInteger type) {
                [ws changeRewardShow:type];
                [ws.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            [cell setupState:_showType == 2?0:1];
            [cell setupCellContentWithMoney:self.moneyString count:self.countString];
            return cell;
        }else {
            LCRewardOrderHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderHeaderTableViewCell];
            WS(ws)
            cell.headerBlock = ^(NSInteger type) {
                [ws changeRewardShow:type];
                [ws.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            [cell setupState:_showType == 2?0:1];
            [cell setupCellContentWithCount:self.countString];
            return cell;
        }
    }else {
        if (_showType == 0) {
//            NSInteger type = (indexPath.row - 1) % 7;
//            if (type == 0) {
                LCSpacePostTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTitleTableViewCell];
                LCPostModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
                [cell setupCellContentWithPostId:model.postId pushTime:model.create_time postContent:model.post_title commment:model.reply_count rewardCount:model.reward_count money:model.post_money];
                return cell;
//            }else if (type == 1 || type == 2) {//图片
//                LCSpacePostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTableViewCell];
//                NSString *contentText = type == 1 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
//                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" images:@[@"",@""]];
//                return cell;
//            }else if (type == 3 || type == 4) {//只要语言
//                LCSpacePostVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceTableViewCell];
//                NSString *contentText = type == 3 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
//                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" voiceSecond:@"50"];
//                return cell;
//            }else {//语言+图片
//                LCSpacePostVoiceImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceImageTableViewCell];
//                NSString *contentText = type == 5 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
//                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" images:@[@"",@"",@""] voiceSecond:@"51"];
//                return cell;
//            }
        }else if (_showType == 1) {
            LCSpaceGuessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceGuessTableViewCell];
            LCGuessModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
            [cell setupCellContentWithId:model.user_id time:model.create_time title:model.quiz_title];
            return cell;
        }else {
            if (_showType == 2) {
                LCRewardRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordTableViewCell];
                LCSendRecordModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
                [cell setupContentWithId:model.post_id time:model.add_time count:@"15" money:model.money];
                return cell;
            }else {
                LCRewardOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderTableViewCell];
                LCSendRecordModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
                [cell setupContentWithName:model.nickname userId:model.user_id index:indexPath.row photo:model.logo];
                return cell;
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_showType == 2) {
            return 90 + 60;
        }else {
            return 30;
        }
    }else {
        if (_showType == 0) {
//            NSInteger type = (indexPath.row - 1) % 7;
//            if (type == 0) {
                return 123;
//            }else if (type == 1) {
//                return 183;
//            }else if (type == 2) {
//                return 183 - 36 - 10;
//            }else if (type == 3) {
//                return 173;
//            } else if (type == 4){
//                return 173 - 36 - 13;
//            }else if (type == 5) {
//                return 227;
//            }else {
//                return 227 - 36 - 10;
//            }
        }else if (_showType == 1) {
            return 80;
        }else {
            return 74;
        }
    }
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 0) {
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        LCPostModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
        LCHomePostModel *postModel = [[LCHomePostModel alloc]init];
        postModel.post_id = model.post_id;
        postModel.post_title = model.post_title;
        postModel.post_type = model.post_type;
        postModel.post_money = model.post_money;
        postModel.post_vipmoney = model.post_vipmoney;
        postModel.user_id = model.user_id;
        postModel.nickname = model.nickname;
        postModel.logo = model.logo;
        postModel.reply_count = [model.reply_count integerValue];
        postModel.reward_count = model.reward_count;
        postModel.reward_money = @"0";
        postModel.create_time = model.create_time;
        detail.postModel = postModel;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (_showType == 1){
        LCGuessModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row - 1];
        LCGuessDetailVC *detail = [[LCGuessDetailVC alloc]init];
        detail.guessModel = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark view
- (LCSpaceMyOrderView *)orderView {
    if (!_orderView) {
        LCSpaceMyOrderView *orderView = [[LCSpaceMyOrderView alloc]init];
        _orderView = orderView;
        [self.view addSubview:orderView];
        WS(ws)
        [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.view);
            make.height.mas_equalTo(49);
            make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
        }];
        [_orderView setupContentWithIndex:nil photo:nil money:KNullTransformNumber(self.my_mchmoney)];
    }
    return _orderView;
}
- (void)initializeMainView {
    _showType = 0;
//    if (![kUserMessageManager.userId isEqualToString:self.userId]) {
//        [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView:)];
//    }
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kLCRewardOrderTableViewCell bundle:nil] forCellReuseIdentifier:kLCRewardOrderTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCRewardRecordTableViewCell bundle:nil] forCellReuseIdentifier:kLCRewardRecordTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCRewardOrderHeaderTableViewCell bundle:nil] forCellReuseIdentifier:kLCRewardOrderHeaderTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCRewardRecordHeaderTableViewCell bundle:nil] forCellReuseIdentifier:kLCRewardRecordHeaderTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpacePostTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpacePostTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpaceGuessTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpaceGuessTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpaceHeaderTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpaceHeaderTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpacePostVoiceTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpacePostVoiceTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpacePostVoiceImageTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpacePostVoiceImageTableViewCell];
    [tableView registerNib:[UINib nibWithNibName:kLCSpacePostTitleTableViewCell bundle:nil] forCellReuseIdentifier:kLCSpacePostTitleTableViewCell];
    
    UIView *headerMainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 335)];
    headerMainView.backgroundColor = [UIColor whiteColor];
    LCUserHomeHeaderView *headerView = [[LCUserHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 304)];
    [headerView changeBgImage:nil];
    [headerView isShowPunchCard:NO];
    self.headerView = headerView;


    LCMySpaceTabView *tabView = [[LCMySpaceTabView alloc]initWithFrame:CGRectMake(0, 295, SCREEN_WIDTH, 40)];
    [headerMainView addSubview:tabView];
    [headerMainView addSubview:headerView];
    tableView.tableHeaderView = headerMainView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
    }];
    tabView.tabbarBlock = ^(NSInteger type) {
        [ws changeShowClick:type];
    };
    headerView.punchBlock = ^(NSInteger type) {
        [ws headerViewClickEvent:type];
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
