//
//  LCMessageForSystemView.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMessageForSystemView.h"
#import "LCPublicNoticeCell.h"
@interface LCMessageForSystemView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@end
@implementation LCMessageForSystemView

- (instancetype)init {
    if(self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)loadFirstData {
    
}
- (void)pullDownRefresh {
    
}
- (void)pullUpLoadMore {
    
}
- (void)detailClick:(LCPublicNoticeCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LSKLog(@"%ld",indexPath.row);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCPublicNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPublicNoticeCell];
    [cell setupCellContent:@"哈哈" detail:@"凯凯" isShowDetail:indexPath.row % 2];
    @weakify(self)
    [cell setBlock:^(id clickDetail) {
        @strongify(self)
        [self detailClick:clickDetail];
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 86 + 80;
    }else {
        return 86 + 80 + 47;
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
