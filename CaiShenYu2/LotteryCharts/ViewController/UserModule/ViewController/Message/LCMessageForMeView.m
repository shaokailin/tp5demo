

//
//  LCMessageForMeView.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMessageForMeView.h"
#import "LCMeCareCell.h"
#import "LCMeCommentCell.h"
#import "LCMeShangCell.h"
#import "LCUserNoticeVM.h"
#import "LCMePostNoticeCell.h"
#import "LCPostDetailVC.h"
#import "LCHomePostModel.h"
#import "LCGuessDetailVC.h"
#import "LCMySpaceMainVC.h"
@interface LCMessageForMeView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isLoading;
    NSInteger _selectedRow;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCUserNoticeVM *viewModel;
@end
@implementation LCMessageForMeView

- (instancetype)init {
    if(self = [super init]) {
        [self _layoutMainView];
        [self bindSignal];
    }
    return self;
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCUserNoticeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self endRefreshing];
            [self.mainTableView reloadData];
            [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.listArray.count];
        }else {
            if (self->_selectedRow != -1 && self->_selectedRow < self.viewModel.listArray.count) {
                LCUserNoticeModel *model = [self.viewModel.listArray objectAtIndex:self->_selectedRow];
                model.is_read = @"0";
                [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->_selectedRow inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                self->_selectedRow = -1;
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self.viewModel.page == 0) {
            self->_isLoading = NO;
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    [_viewModel getUserNoticeList:NO];
}
- (void)pullUpLoadMore {
    _viewModel.page ++;
    [_viewModel getUserNoticeList:YES];
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getUserNoticeList:YES];
}
- (void)loadFirstData {
    if (!_isLoading) {
        [_viewModel getUserNoticeList:NO];
    }
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel && KJudgeIsArrayAndHasValue(_viewModel.listArray)) {
        return _viewModel.listArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCUserNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    NSString *userName = [model.userMessage objectForKey:@"nickname"];
    NSString *logo = [model.userMessage objectForKey:@"logo"];
    if (model.type == 1 || model.type == 2 || model.type == 5 || model.type == 6) {
        LCMeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeCommentCell];
        [cell setupCellContent:userName time:model.create_time content:[model.userMessage objectForKey:@"message"] img:logo type:model.type == 2 || model.type == 6 ? 1:0];
        return cell;
    }else if(model.type == 7) {
        LCMeCareCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeCareCell];
        [cell setupCellContent:userName time:model.create_time img:logo];
        return cell;
    }else if (model.type == 3){
        LCMePostNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMePostNoticeCell];
        [cell setupCellContent:userName time:model.create_time img:logo content:[model.userMessage objectForKey:@"message"]];
        return cell;
    }else {
        LCMeShangCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeShangCell];
        [cell setupCellContent:userName money:[model.userMessage objectForKey:@"money"] time:model.create_time img:logo];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCUserNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    if ([model.is_read integerValue] == 1) {
        _selectedRow = indexPath.row;
        [self.viewModel changeNoticeRead:model.noticeId];
    }
    UIViewController *jumpController = nil;
    if (model.type < 5 ) {
        LCHomePostModel *detalmodel = [[LCHomePostModel alloc] init];
        detalmodel.user_id = [model.userMessage objectForKey:@"user_id"];
        detalmodel.post_id = [model.userMessage objectForKey:@"post_id"];
        LCPostDetailVC *controller1 = [[LCPostDetailVC alloc]init];
        controller1.postModel = detalmodel;
        jumpController = controller1;
    }else if (model.type < 7) {
        LCGuessDetailVC *detail = [[LCGuessDetailVC alloc]init];
        LCGuessModel *detalmodel = [[LCGuessModel alloc] init];
        detalmodel.quiz_id = [model.userMessage objectForKey:@"post_id"];
        detail.guessModel = detalmodel;
        jumpController = detail;
    }else if (model.type == 7) {
        LCMySpaceMainVC *detail = [[LCMySpaceMainVC alloc]init];
        detail.userId = model.uid;
        jumpController = detail;
    }
    UIViewController *controller = [LSKViewFactory getCurrentViewController];
    [controller.navigationController pushViewController:jumpController animated:YES];
    
}
- (void)_layoutMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kLineMain_Color, 1.0) backgroundColor:nil];
    tableView.rowHeight = 69;
    [tableView registerNib:[UINib nibWithNibName:kLCMeCareCell bundle:nil] forCellReuseIdentifier:kLCMeCareCell];
    [tableView registerNib:[UINib nibWithNibName:kLCMeShangCell bundle:nil] forCellReuseIdentifier:kLCMeShangCell];
    [tableView registerNib:[UINib nibWithNibName:kLCMeCommentCell bundle:nil] forCellReuseIdentifier:kLCMeCommentCell];
    [tableView registerNib:[UINib nibWithNibName:kLCMePostNoticeCell bundle:nil] forCellReuseIdentifier:kLCMePostNoticeCell];
    self.mainTableView = tableView;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}
@end
