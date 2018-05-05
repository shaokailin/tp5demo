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
@interface LCMessageForMeView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@end
@implementation LCMessageForMeView

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCMeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeCommentCell];
        return cell;
    }else if (indexPath.row == 1) {
        LCMeShangCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeShangCell];
        return cell;
    }else {
        LCMeCareCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCMeCareCell];
        return cell;
    }
}

- (void)_layoutMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kLineMain_Color, 1.0) backgroundColor:nil];
    tableView.rowHeight = 69;
    [tableView registerNib:[UINib nibWithNibName:kLCMeCareCell bundle:nil] forCellReuseIdentifier:kLCMeCareCell];
    [tableView registerNib:[UINib nibWithNibName:kLCMeShangCell bundle:nil] forCellReuseIdentifier:kLCMeShangCell];
    [tableView registerNib:[UINib nibWithNibName:kLCMeCommentCell bundle:nil] forCellReuseIdentifier:kLCMeCommentCell];
    self.mainTableView = tableView;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}
@end
