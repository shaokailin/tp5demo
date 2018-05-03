//
//  LCPublicNoticeVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeVC.h"
#import "LCPublicNoticeCell.h"
@interface LCPublicNoticeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTable;
@end

@implementation LCPublicNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公告";
    [self initializeMainView];
}
- (void)pullUpLoadMore {
    
}
- (void)pullDownRefresh {
    
}
- (void)endRefreshing {
//    if (_viewModel.page == 0) {
//        [self.mainTableView.mj_header endRefreshing];
//    }else {
//        [self.mainTableView.mj_footer endRefreshing];
//    }
}
- (void)detailClick:(LCPublicNoticeCell *)cell {
    NSIndexPath *indexPath = [self.mainTable indexPathForCell:cell];
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
- (void)initializeMainView {
    UITableView *tableVIew = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:nil backgroundColor:nil];
    self.mainTable = tableVIew;
    [tableVIew registerNib:[UINib nibWithNibName:kLCPublicNoticeCell bundle:nil] forCellReuseIdentifier:kLCPublicNoticeCell];
    [self.view addSubview:tableVIew];
    [tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    
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
