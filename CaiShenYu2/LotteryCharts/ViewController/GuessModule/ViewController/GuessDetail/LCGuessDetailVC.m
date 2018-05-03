//
//  LCGuessDetailVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessDetailVC.h"
#import "LCPostHeaderTableViewCell.h"
#import "LCPostCommentTableViewCell.h"
#import "LCCommentInputView.h"
#import "LCGuessHeaderView.h"
#import "LCGuessDetailViewModel.h"
#import "LCMySpaceMainVC.h"
#import "LCGuessRuleVC.h"
#import "LCGuessUerListVC.h"

@interface LCGuessDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCGuessHeaderView *headerView;
@property (nonatomic, strong) LCCommentInputView *inputToolbar;
@property (nonatomic, strong) LCGuessDetailViewModel *viewModel;
@property (nonatomic, strong) UIView *headerBgView;
@end

@implementation LCGuessDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationBackButton];
    [self initializeMainView];
    [self.inputToolbar removeFromSuperview];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCGuessDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            if (self.viewModel.page == 0) {
                LCGuessDetailModel *model1 = (LCGuessDetailModel *)model;
                self.guessModel = model1.response;
                _viewModel.period_id = self.guessModel.period_id;
                [self setupHeadViewContent];
                [_viewModel.replyArray removeAllObjects];
            }
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:2000];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_viewModel.page == 0) {
                    [self pullUpLoadMore];
                }
            });
//
        }else if (identifier == 10){
            [self.inputToolbar cleanText];
            self.guessModel.reply_count += 1;
            
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:0 indexPathEnd:0 section:0 animation:UITableViewRowAnimationNone];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:1 indexPathEnd:1 section:0 animation:UITableViewRowAnimationBottom];
        }else if(identifier == 20) {
            self.guessModel.quiz_buynumber = self.guessModel.quiz_buynumber + [self.headerView.countField.text integerValue];
            self.headerView.countField.text = @"1";
            [self.headerView changeCount:self.guessModel.hasCount];
            
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 0) {
            [self endRefreshing];
        }
    }];
    _viewModel.period_id = self.guessModel.period_id;
    _viewModel.quiz_id = self.guessModel.quiz_id;
    [_viewModel getReplyList:NO];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)sendCommentClick:(NSString *)text {
    [self.view endEditing:YES];
    [self.viewModel sendReplyClick:text];
}
- (void)betGuessClick {
    [self.view endEditing:YES];
    if ([self.guessModel.user_id isEqualToString:kUserMessageManager.userId]) {
        [SKHUD showMessageInView:self.view withMessage:@"自己不能接受挑战自己的擂台"];
        return;
    }
    [self.viewModel betGuessWithCount:self.headerView.countField.text];
}
- (void)pullDownRefresh {
    [self.view endEditing:YES];
    _viewModel.page = 0;
    [_viewModel getReplyList:YES];
}
- (void)pullUpLoadMore {
    [self.view endEditing:YES];
    _viewModel.page += 1;
    [_viewModel getReplyList:YES];
}
- (void)showRule {
    [self.view endEditing:YES];
    LCGuessRuleVC *ruleVC = [[LCGuessRuleVC alloc]init];
    [self.navigationController pushViewController:ruleVC animated:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.replyArray.count + 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCPostHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostHeaderTableViewCell];
        [cell setupCount:self.guessModel.reply_count type:0];
        return cell;
    }else {
        LCPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostCommentTableViewCell];
        LCGuessReplyModel *model = [_viewModel.replyArray objectAtIndex:indexPath.row - 1];
        [cell setupPhoto:model.logo name:model.nickname userId:model.mch_no index:indexPath.row time:model.create_time content:model.message];
        WS(ws)
        cell.photoBlock = ^(id clickCell) {
            [ws photoClick:clickCell];
        };
        return cell;
    }
}
- (void)photoClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LCGuessReplyModel *model = [_viewModel.replyArray objectAtIndex:indexPath.row - 1];
    LCMySpaceMainVC *detail = [[LCMySpaceMainVC alloc]init];
    detail.userId = model.user_id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }else {
        return 60;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.inputToolbar.inputField resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"规则" target:self action:@selector(showRule)];
     WS(ws)
    LCCommentInputView *inputView = [[LCCommentInputView alloc]init];
    inputView.frame = CGRectMake(0, self.viewMainHeight - 44 - self.tabbarBetweenHeight, SCREEN_WIDTH, 44);
    inputView.sendBlock = ^(NSString *text) {
        [ws sendCommentClick:text];
    };
    self.inputToolbar = inputView;
    [self.view addSubview:inputView];
   
    
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCPostCommentTableViewCell bundle:nil] forCellReuseIdentifier:kLCPostCommentTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCPostHeaderTableViewCell bundle:nil] forCellReuseIdentifier:kLCPostHeaderTableViewCell];
    LCGuessHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LCGuessHeaderView" owner:self options:nil] lastObject];
    self.headerView = headerView;
    CGFloat height = 0;
    if (self.guessModel.contentHeight > 45) {
        height = 330;
    }else {
        height += 272 + self.guessModel.contentHeight;
    }
     self.headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
   
    [ self.headerBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(ws.headerBgView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    mainTableView.tableFooterView = [[UIView alloc]init];
    mainTableView.tableHeaderView = self.headerBgView;

    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-44 - ws.tabbarBetweenHeight);
    }];
    headerView.hederBlock = ^(NSInteger type) {
        [ws betGuessClick];
    };
    headerView.frameBlock = ^(CGFloat height) {
        [ws changeHeaderFrame:height];
    };
    
    [headerView setMyBlock:^(UIButton *sender) {
        LCGuessUerListVC *lcuserListVC = [[LCGuessUerListVC alloc] init];
        lcuserListVC.quiz_id =  self.guessModel.quiz_id;
        [self.navigationController pushViewController:lcuserListVC animated:YES];
    }];
    
    
    [self setupHeadViewContent];
}
- (void)changeHeaderFrame:(CGFloat)height {
    self.mainTableView.tableHeaderView = nil;
    CGRect frame = self.headerBgView.frame;
    frame.size.height = height;
    self.headerBgView.frame = frame;
    self.mainTableView.tableHeaderView = self.headerBgView;
}
- (void)setupHeadViewContent {
    NSInteger type = self.guessModel.quiz_type == 2?0:1;
    NSString *number1 = nil;
    NSString *number2 = nil;
    if (type == 0) {
        self.title = @"杀两码";
        if (KJudgeIsNullData(self.guessModel.quiz_answer)) {
            NSArray *answerArray = [self.guessModel.quiz_answer componentsSeparatedByString:@","];
            if (answerArray.count > 0) {
                number1 = NSStringFormat(@"%@",[answerArray objectAtIndex:0]);
            }
            if (answerArray.count > 1) {
                number2 = NSStringFormat(@"%@",[answerArray objectAtIndex:1]);
            }
        }
    }else {
        self.title = @"猜大小";
        number1 = self.guessModel.quiz_answer;
    }
    [self.headerView setupContentTitle:self.guessModel.quiz_title money:self.guessModel.quiz_money count:self.guessModel.hasCount number1:number1 number2:number2 type:type model:self.guessModel];
    [self.headerView setupContentWithContent:self.guessModel.quiz_content height:self.guessModel.contentHeight];
    [self.headerView hidenEventViewWithAuthor:[self.guessModel.user_id isEqualToString:kUserMessageManager.userId]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (UIView *)inputAccessoryView {
    if (self.headerView.isBecome) {
        return nil;
    }
    return self.inputToolbar;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.headerView.isBecome) {
        [self.view endEditing:YES];
    }
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
