//
//  LCPostDetailVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailVC.h"
#import "LCPostHeaderTableViewCell.h"
#import "LCPostCommentTableViewCell.h"
#import "LCCommentInputView.h"
#import "LCPostDetailHeaderView.h"
#import "LCPostDetailViewModel.h"
@interface LCPostDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    BOOL _isNeedSend;
    BOOL _isViewAppear;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCCommentInputView *inputToolbar;
@property (nonatomic, weak) LCPostDetailHeaderView *headerView;
@property (nonatomic, strong) LCPostDetailViewModel *viewModel;
@property (nonatomic, strong) UIView *headerBgView;
@end

@implementation LCPostDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"帖子详情";
    [self backToNornalNavigationColor];
    [self addNavigationBackButton];
    self.type = [self.postModel.user_id isEqualToString:kUserMessageManager.userId]? 1:0;
    _isNeedSend = [self.postModel.post_type integerValue] == 2? YES:NO;
    [self initializeMainView];
    [self.inputToolbar removeFromSuperview];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCPostDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        if (identifier == 0 || identifier == 1) {
            @strongify(self)
            if (identifier == 0) {
                LCPostDetailModel *detailModel = (LCPostDetailModel *)model;
                self.postModel.post_id = detailModel.post_id;
                self.postModel.post_title = detailModel.post_title;
                self.postModel.post_content = detailModel.post_content;
                self.postModel.post_upload = detailModel.post_upload;
                self.postModel.post_type = detailModel.post_type;
                self.postModel.post_money = detailModel.post_money;
                self.postModel.post_vipmoney = detailModel.post_vipmoney;
                self.postModel.user_id = detailModel.user_id;
                self.postModel.reward_count = detailModel.reward_count;
                self.postModel.reward_money = detailModel.reward_money;
                self.postModel.create_time = detailModel.create_time;
                self.postModel.reply_count = detailModel.reply_count;
                
                self.headerView.isCare = detailModel.is_follow;
                _isNeedSend = NO;
                BOOL isCanShow = YES;
                if (detailModel.return_status < 4) {
                    isCanShow  = NO;
                    if (detailModel.return_status == 3) {
                        _isNeedSend =  YES;
                        [SKHUD showMessageInView:self.view withMessage:@"请回复才能查看帖子内容！"];
                    }else if (detailModel.return_status == 2) {
                        [self showAlterView];
                    }
                }
                [self setupHeadView:isCanShow isFirst:NO];
            }
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.replyArray.count];
        }else if (identifier == 200) {
            self.postModel = model;
            [self setupHeadView:NO isFirst:YES];
            
        }else if (identifier == 10){
            [self.inputToolbar cleanText];
            self.postModel.reply_count += 1;
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:0 indexPathEnd:0 section:0 animation:UITableViewRowAnimationNone];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:1 indexPathEnd:1 section:0 animation:UITableViewRowAnimationBottom];
        }else if (identifier == 20) {
            [self.headerView setupRewardCount:[self.postModel.reward_count integerValue] + 1];
        }else if (identifier == 30) {
            self.headerView.isCare = !self.headerView.isCare;
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
         if (identifier == 1) {
            if (self.viewModel.page == 0) {
                [self.mainTableView reloadData];
            }
            [self endRefreshing];
        }else if (identifier == 200) {
            [self performSelector:@selector(navigationBackClick) withObject:nil afterDelay:1.0];
        }
    }];
    _viewModel.postId = self.postModel.post_id;
    [_viewModel getPostDetail:NO];
}
- (void)showAlterView {
    @weakify(self)
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"支付金币查看内容" message:NSStringFormat(@"\n\n\n是否支付%@金币查看该帖\n",self.postModel.post_money) delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
    [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 1) {
            
            [self.viewModel payForShowEvent];
        }else {
            [self navigationBackClick];
        }
    }];
    [alterView show];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)pullDownRefresh {
    [_viewModel getPostDetail:YES];
}
- (void)pullUpLoadMore {
    [_viewModel getReplyList];
}
- (void)headerViewEvent:(NSInteger)type index:(NSInteger)index {
    if (type == 0) {
        [self.viewModel attentionPost:self.headerView.isCare];
    }else if (type == 1){
        
    }else {
        [self getRewardEvent];
    }
}
- (void)getRewardEvent {
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"打赏金额" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [customAlertView textFieldAtIndex:0];
    nameField.keyboardType = UIKeyboardTypePhonePad;
    nameField.placeholder = @"请输入打赏金额";
    [customAlertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        if (KJudgeIsNullData(nameField.text) && [nameField.text integerValue] > 0) {
            [self.viewModel rewardPostMoney:nameField.text];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"没有输入打赏金额"];
        }
    }
}
- (void)sendCommentClick:(NSString *)text {
    [self.view endEditing:YES];
    self.viewModel.isNeedSend = _isNeedSend;
    [self.viewModel sendReplyText:text];
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
        [cell setupCount:self.type == 1?[self.postModel.reward_count integerValue]:self.postModel.reply_count type:self.type];
        return cell;
    }else {
        LCPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostCommentTableViewCell];
        LCPostReplyModel *model = [self.viewModel.replyArray objectAtIndex:indexPath.row - 1];
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
    [self.view endEditing: YES];
    [self.inputToolbar.inputField resignFirstResponder];
}
- (void)initializeMainView {
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
    LCPostDetailHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostDetailHeaderView" owner:self options:nil] lastObject];
    self.headerView = headerView;
    CGFloat height = self.type == 0 ? 272 + 80 : 80 + 200;
    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.headerBgView = headerBgView;
    [headerBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(headerBgView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    mainTableView.tableHeaderView = headerBgView;
    mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-44 - ws.tabbarBetweenHeight);
    }];
    [self setupHeadView:NO isFirst:YES];
    headerView.headerBlock = ^(NSInteger type, NSInteger index) {
        [ws headerViewEvent:type index:index];
    };
    headerView.frameBlock = ^(CGFloat height) {
        ws.mainTableView.tableHeaderView = nil;
        CGRect frame = ws.headerBgView.frame;
        frame.size.height = height;
        ws.headerBgView.frame = frame;
        self.mainTableView.tableHeaderView = self.headerBgView;
    };
}
- (void)setupHeadView:(BOOL)isShow isFirst:(BOOL)isFirst {
    [self.headerView setupContentWithPhoto:self.postModel.logo name:self.postModel.nickname userId:self.postModel.user_id money:self.postModel.post_money title:self.postModel.post_title content:nil postId:self.postModel.post_id time:self.postModel.create_time count:self.postModel.reward_count type:self.type];
    if (isShow) {
        if (KJudgeIsNullData(self.postModel.post_upload)) {
            NSDictionary *dict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[self.postModel.post_upload dataUsingEncoding:NSUTF8StringEncoding]];
            [self.headerView setupContent:self.postModel.post_content media:dict isShow:isShow];
        }
    }else {
        if (isFirst) {
            [self.headerView setupContent:nil media:nil isShow:isShow];
        }else {
            [self.headerView setupContent:self.postModel.post_upload media:nil isShow:isShow];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)canBecomeFirstResponder {
    return _isViewAppear;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isViewAppear = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    
}
- (void)viewWillDisappear:(BOOL)animated {
    _isViewAppear = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputToolbar.inputField resignFirstResponder];
}
- (UIView *)inputAccessoryView {
//    if (self.headerView.isBecome) {
//        return nil;
//    }
    return self.inputToolbar;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.headerView.isBecome) {
//        [self.view endEditing:YES];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
