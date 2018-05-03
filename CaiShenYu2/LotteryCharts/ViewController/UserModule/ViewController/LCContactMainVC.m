//
//  LCContactMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCContactMainVC.h"
#import "LCContactServiceTableViewCell.h"
#import "LCContactViewModel.h"
@interface LCContactMainVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isChange;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCContactViewModel *viewModel;
@end

@implementation LCContactMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系客服";
    [self backToNornalNavigationColor];
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewDidAppear:(BOOL)animated {
    _isChange = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
    }
}
- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getContactList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getContactList:YES];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCContactViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
//        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.contactArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self endRefreshing];
    }];
    [_viewModel getContactList:NO];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.contactArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCContactServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCContactServiceTableViewCell];
    LCCantactModel *model = [_viewModel.contactArray objectAtIndex:indexPath.row];
    [cell setupContentWithPhoto:model.logo name:model.nickname detail:model.remark wxNumber:model.weixin qqNumber:model.qq mobile:model.mobile];
    return cell;
}
- (void)initializeMainView {
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCContactServiceTableViewCell bundle:nil] forCellReuseIdentifier:kLCContactServiceTableViewCell];
    mainTableView.rowHeight = 148;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
