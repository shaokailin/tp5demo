//
//  LCRankingMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingMainVC.h"
#import "LCRankingHeaderView.h"
#import "LCSpaceTableViewCell.h"
#import "LCVipRankingTableViewCell.h"
#import "LCVipTableViewCell.h"
#import "LCRankingPushTableViewCell.h"
#import "LCRankingGoldTableViewCell.h"
@interface LCRankingMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _showType;
}
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation LCRankingMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"彩神榜";
    if (self.isChangeNavi) {
        [self backToNornalNavigationColor];
    }
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)showTypeChange:(NSInteger)type {
    _showType = type;
    [self.mainTableView reloadData];
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)vipCellClick:(id)clickCell {
    NSInteger index = [self.mainTableView indexPathForCell:clickCell].row;
    LSKLog(@"%zd",index);
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 2) {
        LCRankingPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRankingPushTableViewCell];
        [cell setupContentWithIndex:indexPath.row + 1 photo:nil name:@"凯先生" userId:@"码师ID:123456" pushTime:@"1小时前发布" postId:@"帖子ID:123456" postTitle:@"帖子标题" count:@"阅读数：400"];
        return cell;
    }
    if (indexPath.row < 3) {
        LCVipRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCVipRankingTableViewCell];
        NSString *money = _showType == 0 ? @"付币查看  100金币":@"";
        NSString *robMoney = _showType == 0?@"300金币抢此榜":(_showType == 1?@"粉丝：200":@"帖子ID:123456");
        [cell setupContent:indexPath.row + 1 photo:nil postTitle:@"帖子标题" name:@"凯先生" money:money robMoney:robMoney userId:@"码师ID:123456" isShowBtn:_showType];
        if (_showType == 0) {
            WS(ws)
            cell.vipRankingBlock = ^(id clickCell) {
                [ws vipCellClick:clickCell];
            };
        }
        return cell;
    }else if (indexPath.row == 3) {
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else {
        if (_showType == 3) {
            LCRankingGoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRankingGoldTableViewCell];
            [cell setupContentWithIndex:indexPath.row - 1 photo:nil name:@"凯先生" userId:@"码师ID:123456" postId:@"码师ID:123456" postTitle:@"帖子标题"];
            return cell;
        }else {
            LCVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCVipTableViewCell];
            [cell setupContent:indexPath.row photo:nil postTitle:@"帖子标题" name:@"凯先生" money:@"付币查看  100金币" robMoney:@"300金币抢此榜" userId:@"码师ID:123456" isShowBtn:_showType == 0?YES:NO];
            if (_showType == 0) {
                WS(ws)
                cell.vipBlock = ^(id clickCell) {
                    [ws vipCellClick:clickCell];
                };
            }
            return cell;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 2) {
        return 80;
    }
    if (indexPath.row < 3) {
        return 120;
    }else if (indexPath.row == 3) {
        return 10;
    }else {
        if (_showType == 3) {
            return 65;
        }
        return 90;
    }
}
- (void)initializeMainView {
    LCRankingHeaderView *headerView = [[LCRankingHeaderView alloc]init];
    WS(ws)
    headerView.headerBlock = ^(NSInteger type) {
        [ws showTypeChange:type];
    };
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(40);
    }];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCVipTableViewCell bundle:nil] forCellReuseIdentifier:kLCVipTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCVipRankingTableViewCell bundle:nil] forCellReuseIdentifier:kLCVipRankingTableViewCell];
    [mainTableView registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCRankingPushTableViewCell bundle:nil] forCellReuseIdentifier:kLCRankingPushTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCRankingGoldTableViewCell bundle:nil] forCellReuseIdentifier:kLCRankingGoldTableViewCell];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(40.5, 0, ws.tabbarBetweenHeight, 0));
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
