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
@interface LCGuessDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCGuessHeaderView *headerView;
@property (nonatomic, strong) LCCommentInputView *inputToolbar;
@end

@implementation LCGuessDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"猜大小";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self.inputToolbar removeFromSuperview];
}

- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)showRule {
    [self.view endEditing:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCPostHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostHeaderTableViewCell];
        [cell setupCount:self.guessModel.reply_count type:0];
        return cell;
    }else {
        LCPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostCommentTableViewCell];
        [cell setupPhoto:nil name:@"凯先生" userId:@"码师ID:123456" index:indexPath.row time:@"10月10日  12:23" content:@"内容内容"];
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
- (void)sendCommentClick:(NSString *)text {
    
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
    
    mainTableView.tableHeaderView = headerBgView;

    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-44);
    }];
    [self setupHeadViewContent];
}
- (void)setupHeadViewContent {
    NSInteger type = self.guessModel.quiz_type == 2?0:1;
    NSString *number1 = nil;
    NSString *number2 = nil;
    if (type == 0) {
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
