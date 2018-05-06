//
//  LCRepeatUserVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/6.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCRepeatUserVC.h"
#import "LCPostCommentTableViewCell.h"
#import "LCPostReplyModel.h"
#import "LCCommentInputView.h"
#import "LCPostDetailViewModel.h"
#import "LCMySpaceMainVC.h"
#import "LCRepeatHeaderCell.h"
@interface LCRepeatUserVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    BOOL _isNeedSend;
    BOOL _isViewAppear;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCCommentInputView *inputToolbar;
@property (nonatomic, strong) LCPostDetailViewModel *viewModel;
@end

@implementation LCRepeatUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.navigationItem.title = @"评论";
    [self backToNornalNavigationColor];
    [self initializeMainView];
    
    [self bindSignal];
    
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCPostDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        if (identifier == 0 || identifier == 1) {
            @strongify(self)
            if (identifier == 10){
            [self.inputToolbar cleanText];
//            self.postModel.reply_count += 1;
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:0 indexPathEnd:0 section:0 animation:UITableViewRowAnimationNone];
            [self.mainTableView exitTableViewWithType:LSKTableViewExitType_Insert indexPathStart:1 indexPathEnd:1 section:0 animation:UITableViewRowAnimationBottom];
            }else {
                [self endRefreshing];
                [self.mainTableView reloadData];
                [LSKViewFactory setupFootRefresh:self.mainTableView page:self->_viewModel.page currentCount:self->_viewModel.replyArray.count];
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 1) {
            if (self.viewModel.page == 0) {
                [self.mainTableView reloadData];
            }
            [self endRefreshing];
        }
    }];
    _viewModel.postId = self.postId;
    _viewModel.userId = self.model.user_id;
   [_viewModel getReplyList];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)pullDownRefresh {
    [_viewModel getReplyList];
}
- (void)pullUpLoadMore {
    [_viewModel getReplyList];
}
- (void)sendCommentClick:(NSString *)text {
    [self.view endEditing:YES];
    self.viewModel.isNeedSend = _isNeedSend;
    [self.viewModel sendReplyText:text];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (_viewModel) {
//        return _viewModel.replyArray.count + 2;
//    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        LCRepeatHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCRepeatHeaderCell];
        cell.countLbl.text = NSStringFormat(@"%d条回复",12);
        return cell;
    }else {
        LCPostCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPostCommentTableViewCell];
        if (indexPath.row == 0) {
            [cell setupPhoto:self.model.logo name:self.model.nickname userId:self.model.mch_no count:[self.model.reply_count integerValue] time:self.model.create_time content:self.model.message  isHiden:YES];
        }else {
            LCPostReplyModel *model = [self.viewModel.replyArray objectAtIndex:indexPath.row - 1];
            [cell setupPhoto:model.logo name:model.nickname userId:model.mch_no count:[model.reply_count integerValue] time:model.create_time content:model.message isHiden:NO];
        }
        WS(ws)
        cell.photoBlock = ^(id clickCell) {
            [ws photoClick:clickCell];
        };
        return cell;
    }
}

- (void)photoClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LCPostReplyModel *model = nil;
    if (indexPath.row == 0) {
        model = self.model;
    }else {
        model = [_viewModel.replyArray objectAtIndex:indexPath.row - 2];
    }
    LCMySpaceMainVC *detail = [[LCMySpaceMainVC alloc]init];
    detail.userId = model.user_id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 41;
    }else {
        LCPostReplyModel *model = nil;
        if (indexPath.row == 0) {
            model = self.model;
        }else {
            [self.viewModel.replyArray objectAtIndex:indexPath.row - 2];
        }
        return model.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing: YES];
    [self.inputToolbar.inputField resignFirstResponder];
    if (indexPath.row > 1) {
        LCPostReplyModel *model = [self.viewModel.replyArray objectAtIndex:indexPath.row - 2];
        LCRepeatUserVC *repeat = [[LCRepeatUserVC alloc]init];
        repeat.postId = self.postId;
        repeat.model = model;
        [self.navigationController pushViewController:repeat animated:YES];
        
    }
}

- (void)initializeMainView {
    WS(ws)
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCPostCommentTableViewCell bundle:nil] forCellReuseIdentifier:kLCPostCommentTableViewCell];
    [mainTableView registerNib:[UINib nibWithNibName:kLCRepeatHeaderCell bundle:nil] forCellReuseIdentifier:kLCRepeatHeaderCell];
    mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-44 - ws.tabbarBetweenHeight);
    }];
    LCCommentInputView *inputView = [[LCCommentInputView alloc]init];
    inputView.frame = CGRectMake(0, self.viewMainHeight - 44 - self.tabbarBetweenHeight, SCREEN_WIDTH, 44);
    inputView.placeholdString = NSStringFormat(@"评论%@用户:",self.model.nickname);
    inputView.StatusNav_Height = self.tabbarBetweenHeight + self.navibarHeight + STATUSBAR_HEIGHT;
    inputView.sendBlock = ^(NSString *text) {
        [ws sendCommentClick:text];
    };
    self.inputToolbar = inputView;
    [self.view addSubview:inputView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputToolbar.inputField resignFirstResponder];
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
