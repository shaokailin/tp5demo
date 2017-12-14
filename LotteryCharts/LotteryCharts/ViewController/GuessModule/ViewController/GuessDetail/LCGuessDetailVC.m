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
@interface LCGuessDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCGuessHeaderView *headerView;
@property (nonatomic, strong) LCCommentInputView *inputToolbar;
@property (nonatomic, strong) LCGuessDetailViewModel *viewModel;
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
                [self setupHeadViewContent];
            }
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.replyArray.count];
        }else if (identifier == 10){
            [self.inputToolbar cleanText];
            self.guessModel.reply_count += 1;
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:0 indexPathEnd:0 section:0 animation:UITableViewRowAnimationNone];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:1 indexPathEnd:1 section:0 animation:UITableViewRowAnimationBottom];
        }else {
            
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
        [cell setupPhoto:model.logo name:model.nickname userId:model.user_id index:indexPath.row time:model.create_time content:model.message];
        return cell;
    }
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
    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 272)];
    [headerBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(headerBgView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    mainTableView.tableFooterView = [[UIView alloc]init];
    mainTableView.tableHeaderView = headerBgView;

    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-44 - ws.tabbarBetweenHeight);
    }];
    headerView.hederBlock = ^(NSInteger type) {
        [ws betGuessClick];
    };
    [self setupHeadViewContent];
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
                number1 = [answerArray objectAtIndex:0];
            }
            if (answerArray.count > 1) {
                number2 = [answerArray objectAtIndex:1];
            }
        }
    }else {
        self.title = @"猜大小";
        number1 = self.guessModel.quiz_answer;
    }
    [self.headerView setupContentTitle:self.guessModel.quiz_title money:self.guessModel.quiz_money count:[self.guessModel.quiz_number integerValue] - [self.guessModel.quiz_buynumber integerValue] number1:number1 number2:number2 type:type];
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
