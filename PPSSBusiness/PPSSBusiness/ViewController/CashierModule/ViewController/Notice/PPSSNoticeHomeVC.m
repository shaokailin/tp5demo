//
//  PPSSNoticeHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSNoticeHomeVC.h"
#import "PPSSNoticeHomeTableViewCell.h"
#import "PPSSNoticeDetailVC.h"
#import "PPSSNoticeListModel.h"
#import "PPSSNoticeListViewModel.h"
#import "PPSSWebVC.h"
@interface PPSSNoticeHomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) PPSSNoticeListViewModel *viewModel;
@end

@implementation PPSSNoticeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kNoticeList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark - public
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSNoticeListViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.noticeListArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self endRefreshing];
    }];
    [self.viewModel getNoticeList:NO];
}
- (void)pullUpLoadMore {
    self.viewModel.page += 1;
    [self.viewModel getNoticeList:YES];
}
- (void)pullDownRefresh {
    self.viewModel.page = 0;
    [self.viewModel getNoticeList:YES];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel && self.viewModel.noticeListArray) {
        return self.viewModel.noticeListArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSNoticeHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSNoticeHomeTableViewCell];
    PPSSNoticeModel *model = [self.viewModel.noticeListArray objectAtIndex:indexPath.row];
    [cell setupContentWithTitle:model.title date:model.time];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSWebVC *detail = [[PPSSWebVC alloc]init];
    PPSSNoticeModel *model = [self.viewModel.noticeListArray objectAtIndex:indexPath.row];
    detail.loadUrl = model.address;
    detail.titleString = model.title;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 界面
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSNoticeHomeTableViewCell class] forCellReuseIdentifier:kPPSSNoticeHomeTableViewCell];
    tableView.rowHeight = 44;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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
