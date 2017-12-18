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
    if (index > 2) {
        index -= 1;
    }
    LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:index];
    self.viewModel.postId = model.post_id;
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"抢榜金额" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [customAlertView textFieldAtIndex:0];
    nameField.keyboardType = UIKeyboardTypePhonePad;
    nameField.placeholder = @"请输入抢榜金额";
    [customAlertView show];
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
        if (count == 0) {
            return count;
        }
        if (_showType == 2) {
            return count;
        }else {
//            if (_showType == 1) {
//                if (KJudgeIsArrayAndHasValue(_viewModel.topArray)) {
//                    count += _viewModel.topArray.count;
//                    count += 1;
//                }
//            }else {
                if (count > 3) {
                    count += 1;
                }
//            }
            return count;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 2) {
        LCRankingPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRankingPushTableViewCell];
        LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
        [cell setupContentWithIndex:indexPath.row + 1 photo:model.logo name:model.nickname userId:model.mch_no pushTime:model.create_time postId:model.post_id postTitle:model.post_title count:model.make_click];
        [cell setupTypeThreeContent:nil isThree:NO];
        return cell;
    }
    if (indexPath.row < 3) {
        LCVipRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCVipRankingTableViewCell];
        if (_showType == 1) {
           LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
            [cell setupContent:indexPath.row + 1 photo:model.logo postTitle:nil name:model.nickname money:nil robMoney:NSStringFormat(@"粉丝：%@",model.c) userId:model.mch_no isShowBtn:NO];
            [cell setupTypeThreeContent:nil isThree:NO];
        }else {
            LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:indexPath.row];
            NSString *money = _showType == 0 ? NSStringFormat(@"付币查看  %@金币",model.post_money):@"";
            NSString *robMoney = _showType == 0?NSStringFormat(@"%@金币抢此榜",model.post_vipmoney):(_showType == 1?@"粉丝：200":NSStringFormat(@"帖子ID:%@",model.post_id));
            [cell setupContent:indexPath.row + 1 photo:model.logo postTitle:model.post_title name:model.nickname money:money robMoney:robMoney userId:model.mch_no isShowBtn:_showType == 0 && indexPath.row != 0?YES:NO];
            if (_showType == 3) {
                [cell setupTypeThreeContent:model.reward_money isThree:YES];
            }else {
                [cell setupTypeThreeContent:nil isThree:NO];
            }
        }
        if (_showType == 0) {
            WS(ws)
            cell.vipRankingBlock = ^(id clickCell) {
                [ws vipCellClick:clickCell];
            };
        }
        return cell;
        
    }
    else if  (indexPath.row == 3){
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else {
        NSInteger index = indexPath.row - 1;
        if (_showType !=3) {
            LCVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCVipTableViewCell];
            if (_showType == 1) {
                LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:index];
                [cell setupContent:index + 1 photo:model.logo postTitle:nil name:model.nickname money:@"" robMoney:NSStringFormat(@"粉丝：%@",model.c) userId:model.mch_no isShowBtn:NO];
                [cell setShowType:1];
            }else {
                LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:index];
                [cell setupContent:index + 1 photo:model.logo postTitle:model.post_title name:model.nickname money:NSStringFormat(@"付币查看  %@金币",model.post_money) robMoney:NSStringFormat(@"%@金币抢此榜",model.post_vipmoney) userId:model.mch_no isShowBtn:_showType == 0?([model.user_id isEqualToString:kUserMessageManager.userId] == YES?YES:NO):NO];
            }
            if (_showType == 0) {
                WS(ws)
                cell.vipBlock = ^(id clickCell) {
                    [ws vipCellClick:clickCell];
                };
            }
            return cell;
        }else {
            LCRankingPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRankingPushTableViewCell];
            LCHomePostModel *model = [self.viewModel.postArray objectAtIndex:index];
            [cell setupContentWithIndex:index + 1 photo:model.logo name:model.nickname userId:model.mch_no pushTime:model.create_time postId:model.post_id postTitle:model.post_title count:nil];
            [cell setupTypeThreeContent:model.reward_money isThree:YES];
            return cell;
        }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCHomePostModel *model = nil;
    if (_showType == 2) {
        model = [self.viewModel.postArray objectAtIndex:indexPath.row];
    }else if (_showType == 1){
        NSInteger index = indexPath.row > 2?indexPath.row - 1:indexPath.row;
        LCRankingRenModel *model = [self.viewModel.postArray objectAtIndex:index];
        LCMySpaceMainVC *space = [[LCMySpaceMainVC alloc]init];
        space.userId = model.mch_id;
        [self.navigationController pushViewController:space animated:YES];
        return;
    }else {
        NSInteger index = indexPath.row > 2?indexPath.row - 1:indexPath.row;
        model = [self.viewModel.postArray objectAtIndex:index];
    }
    LCPostDetailVC *detail = [[LCPostDetailVC alloc]init];
    detail.postModel = model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showType == 2) {
        return 80;
    }
    if (indexPath.row < 3) {
        if (_showType == 1) {
            return 93;
        }else if (_showType == 3){
            return 135;
        }
        else {
            return 120;
        }
    }else if (indexPath.row == 3) {
        return 10;
    }else {
        if (_showType == 3) {
            return 80;
        }else if (_showType == 1) {
            return 65;
        }
        return 90;
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
