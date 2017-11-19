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
@interface LCMySpaceMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isChange;
    NSInteger _showType;
    NSInteger _orderType;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCUserHomeHeaderView *headerView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) LCSpaceMyOrderView *orderView;
@end

@implementation LCMySpaceMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    self.title = @"码师空间";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        _isChange = NO;
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
    _isChange = YES;
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)showMeunView:(UIButton *)sender {
    
}
- (void)changeShowClick:(NSInteger)type {
    _showType = type;
    [self.mainTableView reloadData];
    [self showMyOrderMessage];
}
- (void)changeRewardShow:(NSInteger)type {
    _orderType = type;
    [self.mainTableView reloadData];
    [self showMyOrderMessage];
}
- (void)showMyOrderMessage {
    if (_orderType == 1 && _showType == 2) {
        self.orderView.hidden = NO;
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
    return 10 + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_showType == 0 || _showType == 1) {
            LCSpaceHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceHeaderTableViewCell];
            [cell setupCellContentWithCount:@"200"];
            return cell;
        }else if (_showType == 2 && _orderType == 0) {
            LCRewardRecordHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordHeaderTableViewCell];
            WS(ws)
            cell.headerBlock = ^(NSInteger type) {
                [ws changeRewardShow:type];
                [ws.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            [cell setupState:_orderType];
            [cell setupCellContentWithMoney:@"300,2000" count:@"200"];
            
            return cell;
        }else {
            LCRewardOrderHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderHeaderTableViewCell];
            WS(ws)
            cell.headerBlock = ^(NSInteger type) {
                [ws changeRewardShow:type];
                [ws.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            };
            [cell setupState:_orderType];
            [cell setupCellContentWithCount:@"200"];
            return cell;
        }
    }else {
        if (_showType == 0) {
            NSInteger type = (indexPath.row - 1) % 7;
            if (type == 0) {
                LCSpacePostTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTitleTableViewCell];
                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:@"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容" commment:@"200" rewardCount:@"200" money:@"200"];
                return cell;
            }else if (type == 1 || type == 2) {//图片
                LCSpacePostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTableViewCell];
                NSString *contentText = type == 1 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" images:@[@"",@""]];
                return cell;
            }else if (type == 3 || type == 4) {//只要语言
                LCSpacePostVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceTableViewCell];
                NSString *contentText = type == 3 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" voiceSecond:@"50"];
                return cell;
            }else {//语言+图片
                LCSpacePostVoiceImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceImageTableViewCell];
                NSString *contentText = type == 5 ? @"帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容帖子内容":nil;
                [cell setupCellContentWithPostId:@"帖子ID:123456" pushTime:@"10月10日   12:35发布" postContent:contentText commment:@"200" rewardCount:@"300" money:@"10" images:@[@"",@"",@""] voiceSecond:@"51"];
                return cell;
            }
        }else if (_showType == 1) {
            LCSpaceGuessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceGuessTableViewCell];
            [cell setupCellContentWithId:@"码师ID:123456" time:@"10月10日   12:34发布" title:@"标题标题标题"];
            return cell;
        }else {
            if (_orderType == 0) {
                LCRewardRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordTableViewCell];
                [cell setupContentWithId:@"码师ID:123456" time:@"10月10日   12:34发布" count:@"200" money:@"123435"];
                return cell;
            }else {
                LCRewardOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderTableViewCell];
                [cell setupContentWithName:@"凯先生" userId:@"码师ID:123456" index:indexPath.row photo:nil];
                return cell;
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_showType == 2 && _orderType == 0) {
            return 90 + 60;
        }else {
            return 30;
        }
    }else {
        if (_showType == 0) {
            NSInteger type = (indexPath.row - 1) % 7;
            if (type == 0) {
                return 123;
            }else if (type == 1) {
                return 183;
            }else if (type == 2) {
                return 183 - 36 - 10;
            }else if (type == 3) {
                return 173;
            } else if (type == 4){
                return 173 - 36 - 13;
            }else if (type == 5) {
                return 227;
            }else {
                return 227 - 36 - 10;
            }
        }else if (_showType == 1) {
            return 80;
        }else {
            return 74;
        }
    }
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
        [_orderView setupContentWithIndex:@"20" photo:nil money:@"500"];
    }
    return _orderView;
}
- (void)initializeMainView {
    _showType = 0;
    _orderType = 0;
    [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView:)];
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
    [headerView isShowPunchCard:NO];
    self.headerView = headerView;


    LCMySpaceTabView *tabView = [[LCMySpaceTabView alloc]initWithFrame:CGRectMake(0, 295, SCREEN_WIDTH, 40)];
    [headerMainView addSubview:tabView];
    [headerMainView addSubview:headerView];
    tableView.tableHeaderView = headerMainView;
    [headerView setupContentWithName:@"凯先生" userid:@"123456" attention:@"123" teem:@"123"];
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
