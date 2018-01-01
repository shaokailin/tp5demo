//
//  LCGuessListMoreVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessListMoreVC.h"
#import "LCGuessMainTableViewCell.h"
#import "LCGuessDetailVC.h"
#import "LCGuessMainViewModel.h"
#import "LCGuessModel.h"
#import "LCGuessListMoreVC.h"
#import "LCMySpaceMainVC.h"
@interface LCGuessListMoreVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCGuessMainViewModel *viewModel;
@end

@implementation LCGuessListMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多擂台";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCGuessMainViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.guessArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        if (self.viewModel.page == 0) {
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    _viewModel.period_id = self.period_id;
    [_viewModel getGuessMainMoreList:NO];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getGuessMainMoreList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getGuessMainMoreList:YES];
}
- (void)cellClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LCGuessDetailVC *detail = [[LCGuessDetailVC alloc]init];
    LCGuessMainModel *listModel = [_viewModel.guessArray objectAtIndex:indexPath.section];
    LCGuessModel *model = [listModel.quiz_list objectAtIndex:indexPath.row];
    detail.guessModel = model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)photoClick:(id)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    LCMySpaceMainVC *detail = [[LCMySpaceMainVC alloc]init];
    LCGuessMainModel *listModel = [_viewModel.guessArray objectAtIndex:indexPath.section];
    LCGuessModel *model = [listModel.quiz_list objectAtIndex:indexPath.row];
    detail.userId = model.user_id;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel && _viewModel.guessArray) {
        return _viewModel.guessArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCGuessMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCGuessMainTableViewCell];
    LCGuessModel *model = [_viewModel.guessArray objectAtIndex:indexPath.row];
    [cell setupContentWithPhoto:model.logo name:model.nickname userId:model.mch_no postId:model.post_common_id pushTime:model.create_time money:model.quiz_money count:model.hasCount openTime:model.update_time type:model.quiz_type];
    WS(ws)
    cell.cellBlock = ^(id clickCell) {
        [ws cellClick:clickCell];
    };
    cell.photoBlock = ^(id clickCell) {
        [ws photoClick:clickCell];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCGuessDetailVC *detail = [[LCGuessDetailVC alloc]init];
    LCGuessModel *model = [_viewModel.guessArray objectAtIndex:indexPath.row];
    detail.guessModel = model;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)initializeMainView {
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCGuessMainTableViewCell bundle:nil] forCellReuseIdentifier:kLCGuessMainTableViewCell];
    mainTableView.rowHeight = 90;
    mainTableView.tableFooterView = [UIView new];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
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
