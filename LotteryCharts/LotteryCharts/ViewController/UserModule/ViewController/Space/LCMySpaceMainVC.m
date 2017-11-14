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
@interface LCMySpaceMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isChange;
    NSInteger _showType;
    NSInteger _orderType;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCUserHomeHeaderView *headerView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) UIImage *nornalNaviBgImage;
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
    
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10 + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_showType == 0 || _showType == 1) {
            LCSpaceHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceHeaderTableViewCell];
            return cell;
        }else if (_showType == 2 && _orderType == 0) {
            LCRewardRecordHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordHeaderTableViewCell];
            return cell;
        }else {
            LCRewardOrderHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderHeaderTableViewCell];
            return cell;
        }
    }else {
        if (_showType == 0) {
            NSInteger type = indexPath.row % 4;
            if (type == 0) {
                LCSpacePostTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTitleTableViewCell];
                return cell;
            }else if (type == 1) {//图片
                LCSpacePostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostTableViewCell];
                return cell;
            }else if (type == 2) {//只要语言
                LCSpacePostVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceTableViewCell];
                return cell;
            }else {//语言+图片
                LCSpacePostVoiceImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpacePostVoiceImageTableViewCell];
                return cell;
            }
        }else if (_showType == 5) {
            LCSpaceGuessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceGuessTableViewCell];
            return cell;
        }else {
            if (_orderType == 0) {
                LCRewardRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardRecordTableViewCell];
                return cell;
            }else {
                LCRewardOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRewardOrderTableViewCell];
                return cell;
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == 0) {
        if (_showType == 2 && _orderType == 0) {
            return 90 + 60;
        }else {
            return 30;
        }
    }else {
        if (_showType == 0) {
            NSInteger type = indexPath.row % 4;
            if (type == 0) {
                return 133;
            }else if (type == 1) {
                return 183;
            }else if (type == 2){
                return 173;
            }else {
                return 227;
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
        make.edges.equalTo(ws.view);
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
