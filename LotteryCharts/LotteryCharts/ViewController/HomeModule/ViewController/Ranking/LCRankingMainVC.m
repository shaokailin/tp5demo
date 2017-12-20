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
#import "LCRankingViewModel.h"
#import "LCPostDetailVC.h"
#import "LCMySpaceMainVC.h"
#import "LCRankingRenTableViewCell.h"
@interface LCRankingMainVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSInteger _showType;
    BOOL isChange;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCRankingViewModel *viewModel;
@end

@implementation LCRankingMainVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (isChange) {
        isChange = NO;
        [self backToNornalNavigationColor];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    isChange = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"彩神榜";
    if (self.isChangeNavi) {
        [self backToNornalNavigationColor];
    }
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)showTypeChange:(NSInteger)type {
    _showType = type;
    [self getMessage];
}
- (void)vipCellClick:(id)clickCell {
    NSInteger index = [self.mainTableView indexPathForCell:clickCell].row;
    LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:index];
    self.viewModel.postId = model.post_id;
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"抢榜金额" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [customAlertView textFieldAtIndex:0];
    nameField.keyboardType = UIKeyboardTypePhonePad;
    nameField.placeholder = @"请输入抢榜金额";
    [customAlertView show];
}
- (void)photoCellClick:(id)clickCell {
    NSInteger index = [self.mainTableView indexPathForCell:clickCell].row;
    NSString *userId = nil;
    if (_showType == 0) {
        LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:index];
        userId = model.user_id;
    }else if (_showType == 1) {
        LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:index];
        userId = model.mch_id;
    }
    
    LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
    space.userId = userId;
    [self.navigationController pushViewController:space animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        if (KJudgeIsNullData(nameField.text) && [nameField.text integerValue] > 0) {
            self.viewModel.money = nameField.text;
            [self.viewModel upPostViewRanging];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"没有输入抢榜金额"];
        }
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCRankingViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.postArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self.viewModel.page == 0) {
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    [self getMessage];
}
- (void)getMessage {
    _viewModel.page = 0;
    _viewModel.showType = _showType;
    [_viewModel getRankingList:NO];
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
    [_viewModel getRankingList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getRankingList:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_viewModel) {
        return 0;
    }else {
        NSInteger count = _viewModel.postArray.count;
        return count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType != 1) {
        LCVipRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCVipRankingTableViewCell];
        LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
        if (_showType == 0) {
            [cell setupContent:indexPath.row + 1 photo:model.logo postTitle:model.post_title name:model.nickname money:NSStringFormat(@"%@抢此榜",model.post_vipmoney) robMoney:model.post_money userId:model.user_id isShowBtn:_showType == 0 && indexPath.row != 0?YES:NO time:model.create_time postId:model.post_id mch_no:model.mch_no];
        }else if(_showType == 2) {
            [cell setupPushContent:indexPath.row + 1 photo:model.logo postTitle:model.post_title name:model.nickname showCount:model.make_click userId:model.mch_no isShowBtn:NO time:model.create_time postId:model.post_id];
        }else {
            [cell setupShangContent:indexPath.row + 1 photo:model.logo postTitle:model.post_title name:model.nickname money:model.reward_money userId:model.mch_no isShowBtn:NO time:model.create_time postId:model.post_id];
        }
        WS(ws)
        if (_showType == 0) {
            cell.vipRankingBlock = ^(id clickCell) {
                [ws vipCellClick:clickCell];
            };
        }
        cell.photoBlock = ^(id clickCell) {
            [ws photoCellClick:clickCell];
        };
        return cell;
    }else if (_showType == 1) {
        LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
        LCRankingRenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRankingRenTableViewCell];
        [cell setupContent:indexPath.row + 1 photo:model.logo name:model.nickname userId:model.mch_no count:model.c];
        WS(ws)
        cell.photoBlock = ^(id clickCell) {
            [ws photoCellClick:clickCell];
        };
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 1){
        LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
        LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
        space.userId = model.mch_id;
        [self.navigationController pushViewController:space animated:YES];
    }else {
        LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
        LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
        detail.postModel = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType != 1) {
        return 80;
    }else {
        return 65;
    }
}
- (void)initializeMainView {
    _showType = 0;
    LCRankingHeaderView *headerView = [[LCRankingHeaderView alloc]init];
    WS(ws)
    headerView.headerBlock = ^(NSInteger type) {
        [ws showTypeChange:type];
    };
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(41);
    }];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(0xFEC6C6, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCVipTableViewCell bundle:nil] forCellReuseIdentifier:kLCVipTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCVipRankingTableViewCell bundle:nil] forCellReuseIdentifier:kLCVipRankingTableViewCell];
    [mainTableView registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCRankingPushTableViewCell bundle:nil] forCellReuseIdentifier:kLCRankingPushTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCRankingGoldTableViewCell bundle:nil] forCellReuseIdentifier:kLCRankingGoldTableViewCell];
     [mainTableView registerNib:[UINib nibWithNibName:kLCRankingRenTableViewCell bundle:nil] forCellReuseIdentifier:kLCRankingRenTableViewCell];
    
    mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(41, 0, ws.tabbarBetweenHeight, 0));
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
