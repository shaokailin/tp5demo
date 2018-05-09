//
//  LCMessageForSystemView.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMessageForSystemView.h"
#import "LCPublicNoticeCell.h"
#import "LCUserNoticeVM.h"
@interface LCMessageForSystemView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isLoading;
    NSInteger _selectedRow;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCUserNoticeVM *viewModel;
@end
@implementation LCMessageForSystemView

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
    [_viewModel getSystemNoticeList:NO];
}
- (void)pullUpLoadMore {
    _viewModel.page ++;
    [_viewModel getSystemNoticeList:YES];
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getSystemNoticeList:YES];
}
- (void)loadFirstData {
    if (!_isLoading) {
        [_viewModel getSystemNoticeList:NO];
    }
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)detailClick:(LCPublicNoticeCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LSKLog(@"%ld",indexPath.row);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel && KJudgeIsArrayAndHasValue(_viewModel.listArray)) {
        return _viewModel.listArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCPublicNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPublicNoticeCell];
    LCUserNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    [cell setupCellContent:model.title detail:model.content time:model.create_time isShowRed:[model.is_read floatValue] isShowDetail:NO];
    @weakify(self)
    [cell setBlock:^(id clickDetail) {
        @strongify(self)
        [self detailClick:clickDetail];
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2 == 0) {
    LCUserNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
        return 86 + 15 + model.height;
//    }else {
//        return 86 + 80 + 47;
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCUserNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    if ([model.is_read integerValue] == 1) {
        _selectedRow = indexPath.row;
        [self.viewModel changeNoticeRead:model.noticeId];
    }
}
- (void)_layoutMainView {
    UITableView *tableVIew = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:nil backgroundColor:nil];
    self.mainTableView = tableVIew;
    [tableVIew registerNib:[UINib nibWithNibName:kLCPublicNoticeCell bundle:nil] forCellReuseIdentifier:kLCPublicNoticeCell];
    [self addSubview:tableVIew];
    [tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}
@end
