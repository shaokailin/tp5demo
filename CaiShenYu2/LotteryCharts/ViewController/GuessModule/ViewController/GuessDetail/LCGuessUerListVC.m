//
//  LCGuessUerListVC.m
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCGuessUerListVC.h"
#import "LCUserAttentionViewModel.h"
#import "LCUserModuleAPI.h"
#import "LCGuessUserModel.h"
#import "LCGuessUerListCell.h"
#import "UserListModel.h"
@interface LCGuessUerListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) LCGuessUserModel *viewModel;

@end

@implementation LCGuessUerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.title = @"参与人";
    [self initializeMainView];
    [self addNavigationBackButton];
    [self bindSignal];
}

- (void)pullDownRefresh {
    _viewModel.page = 0;
    [_viewModel getUserAttentionList:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getUserAttentionList:YES];
}


- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCGuessUserModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.attentionArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self endRefreshing];
    }];
    _viewModel.quiz_id = self.quiz_id;
    [_viewModel getUserAttentionList:NO];
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
        return _viewModel.attentionArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCGuessUerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCGuessUerListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GuessUserModel *model = _viewModel.attentionArray[indexPath.row];
    
    [cell setupContentWithPhoto:model.logo name:model.nickname mashiID:model.mch_no number:model.betting_num creattime:model.create_time money:model.quiz_money];
    return cell;
}



- (void)initializeMainView {
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:@"LCGuessUerListCell" bundle:nil] forCellReuseIdentifier:@"LCGuessUerListCell"];
    mainTableView.rowHeight = 80;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
