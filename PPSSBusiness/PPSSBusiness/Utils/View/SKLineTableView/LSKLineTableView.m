//
//  LSKLineTableView.m
//  SingleStore
//
//  Created by lsklan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKLineTableView.h"
@interface LSKLineTableView ()<UITableViewDelegate ,UITableViewDataSource>
{
    LSKLineTableViewStype _style;
}
@end
@implementation LSKLineTableView

- (instancetype)initWithStyle:(LSKLineTableViewStype)stype refresh:(SEL)refreshAction LoadMore:(SEL)moreAction {
    if (self = [super init]) {
        _rowHeight = 44;
        _style = stype;
        _tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:refreshAction footRefreshAction:moreAction separatorColor:nil backgroundColor:nil];
        [self addSubview:_tableView];
        WS(ws)
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}

#pragma mark - public method
//刷新事件
- (void)pullDownRefresh {
    if (_delegate && [_delegate respondsToSelector:@selector(pullDownRefresh)]) {
        [_delegate pullDownRefresh];
    }
}
//加载更多事件
- (void)pullUpLoadMore {
    if (_delegate && [_delegate respondsToSelector:@selector(pullUpLoadMore)]) {
        [_delegate pullUpLoadMore];
    }
}
//注册cell
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [_tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}
//行号，统一的
- (void)setRowHeight:(CGFloat)rowHeight {
    if (_rowHeight != rowHeight) {
        _rowHeight = rowHeight;
        [_tableView reloadData];
    }
}
//结束刷新
- (void)endHearerRefreshing {
    [_tableView.mj_header endRefreshing];
}
//结束加载更多
- (void)endFooterRefreshing {
    [_tableView.mj_footer endRefreshing];
}
//设置脚步视图
- (void)setTableFooterView:(UIView *)tableFooterView {
    _tableFooterView = tableFooterView;
    _tableView.tableFooterView = tableFooterView;
}
//设置头部视图
- (void)setTableHeaderView:(UIView *)tableHeaderView {
    _tableHeaderView = tableHeaderView;
    _tableView.tableHeaderView = tableHeaderView;
}
//是否允许点击
- (void)setIsAllowSelect:(BOOL)isAllowSelect {
    _isAllowSelect = isAllowSelect;
    _tableView.allowsSelection = isAllowSelect;
}
- (void)reloadTableView {
    [_tableView reloadData];
}
- (void)exitTableViewWithType:(LSKTableViewExitType)type indexPathStart:(NSInteger)start indexPathEnd:(NSInteger)end section:(NSInteger)section animation:(UITableViewRowAnimation)animation {
    if (start <= 0 && end <= 0) {
        return;
    }
    if (start >= 0 && end >= 0) {
        if (start > end) {
            NSInteger temp = start;
            start = end;
            end = temp;
        }
        if (_style == LSKLineTableViewStype_Top) {
            start = start * 2;
            end = end * 2;
        }else {
            start = start * 2 + 1;
            end = end * 2 + 1;
        }
        NSMutableArray *indexPathArray = [NSMutableArray array];
        if (start == end) {
            [indexPathArray addObject:[NSIndexPath indexPathForRow:start inSection:section]];
        }else {
            while (start <= end) {
                [indexPathArray addObject:[NSIndexPath indexPathForRow:start inSection:section]];
                start ++;
            }
        }
        [_tableView beginUpdates];
        switch (type) {
            case LSKTableViewExitType_Reload:
                [_tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
            case LSKTableViewExitType_Delete:
                [_tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
            case LSKTableViewExitType_Insert:
                [_tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
                
            default:
                break;
        }
        [_tableView endUpdates];
    }
}

#pragma mark -tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self canRespondsToSelector:@selector(lsk_tableView:numberOfRowsInSection:)]) {
        NSInteger count = [self.delegate lsk_tableView:tableView numberOfRowsInSection:section];
        return count * 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((_style == LSKLineTableViewStype_Top && indexPath.row % 2 == 0) || (_style == LSKLineTableViewStype_Botton && indexPath.row % 2 == 1)) {
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else {
        NSInteger index = 0;
        if (_style == LSKLineTableViewStype_Top) {
            index = indexPath.row / 2;
        }else {
            index = (indexPath.row - 1) / 2;
        }
        if ([self canRespondsToSelector:@selector(lsk_tableView:cellForRowAtIndexPath:)]) {
            UITableViewCell *cell = [self.delegate lsk_tableView:tableView cellForRowAtIndexPath:index];
            return cell;
        }
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((_style == LSKLineTableViewStype_Top && indexPath.row % 2 == 0) || (_style == LSKLineTableViewStype_Botton && indexPath.row % 2 == 1)) {
        return 10;
    }else {
        NSInteger index = 0;
        if (_style == LSKLineTableViewStype_Top) {
            index = indexPath.row / 2;
        }else {
            index = (indexPath.row - 1) / 2;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(lsk_heightForRowAtIndex:)]) {
            return [_delegate lsk_heightForRowAtIndex:index];
        }else {
            return self.rowHeight;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((_style == LSKLineTableViewStype_Top && indexPath.row % 2 == 0) || (_style == LSKLineTableViewStype_Botton && indexPath.row % 2 == 1)) {}else {
        NSInteger index = 0;
        if (_style == LSKLineTableViewStype_Top) {
            index = indexPath.row / 2;
        }else {
            index = (indexPath.row - 1) / 2;
        }
        if ([self canRespondsToSelector:@selector(lsk_tableView:didSelectRowAtIndex:)]) {
            [self.delegate lsk_tableView:tableView didSelectRowAtIndex:index];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
- (BOOL)canRespondsToSelector:(SEL)action {
    if (self.delegate && [self.delegate respondsToSelector:action]) {
        return YES;
    }
    return NO;
}

@end
