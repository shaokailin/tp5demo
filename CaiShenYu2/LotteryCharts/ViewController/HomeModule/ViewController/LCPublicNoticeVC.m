//
//  LCPublicNoticeVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeVC.h"
#import "LCPublicNotice1Cell.h"
#import "LCPublicNoticeVM.h"
#import "LCPublicNoticeDetailVC.h"
@interface LCPublicNoticeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    LCPublicNoticeVM *_viewModel;
}
@property (nonatomic, weak) UITableView *mainTable;
@end

@implementation LCPublicNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公告";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self backToNornalNavigationColor];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCPublicNoticeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTable reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTable page:self->_viewModel.page currentCount:self->_viewModel.listArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self->_viewModel.page == 0) {
            [self.mainTable reloadData];
        }
        [self endRefreshing];
    }];
    [_viewModel getPublicData:NO];
}
- (void)pullUpLoadMore {
    _viewModel.page ++;
    [_viewModel getPublicData:YES];
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getPublicData:YES];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTable.mj_header endRefreshing];
    }else {
        [self.mainTable.mj_footer endRefreshing];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel && KJudgeIsArrayAndHasValue(_viewModel.listArray)) {
        return _viewModel.listArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCPublicNotice1Cell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPublicNotice1Cell];
    LCPublicNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    [cell setupCellContent:model.title detail:model.content time:model.update_time];;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   LCPublicNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    if (model.height > 52) {
        return 52 + 96;
    }
    return model.height + 96;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCPublicNoticeModel *model = [_viewModel.listArray objectAtIndex:indexPath.row];
    LCPublicNoticeDetailVC *detail = [[LCPublicNoticeDetailVC alloc]init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)initializeMainView {
    UITableView *tableVIew = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:nil backgroundColor:nil];
    self.mainTable = tableVIew;
    [tableVIew registerNib:[UINib nibWithNibName:kLCPublicNotice1Cell bundle:nil] forCellReuseIdentifier:kLCPublicNotice1Cell];
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
