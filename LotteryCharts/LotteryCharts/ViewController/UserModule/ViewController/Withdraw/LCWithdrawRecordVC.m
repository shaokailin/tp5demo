//
//  LCWithdrawRecordVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawRecordVC.h"
#import "LCWithdrawRecordHeaderView.h"
#import "LCWithdrawRecordTableViewCell.h"
#import "HSPDefineDatePickView.h"
#import "LCWithdrawViewModel.h"
@interface LCWithdrawRecordVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _yearSelect;
    NSInteger _mouthSelect;
    NSInteger _dateSelectType;
    
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCWithdrawRecordHeaderView *searchView;
@property (nonatomic, strong) HSPDefineDatePickView *datePickView;
@property (nonatomic, strong) LCWithdrawViewModel *viewModel;
@end

@implementation LCWithdrawRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现记录";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)headerViewEvent:(NSInteger)type param:(id)param {
    if (type < 2) {
        _dateSelectType = type;
        self.datePickView.datePickerMode = type;
        [self.datePickView showInView];
    }else {
       
    }
}
- (void)changeSearchType:(NSInteger)type {
    if (_dateSelectType == 0) {
        _yearSelect = type;
        [self.searchView setupContentWithLeft:NSStringFormat(@"%zd年",_yearSelect) right:nil];
    }else {
        _mouthSelect = type;
        [self.searchView setupContentWithLeft:nil right:NSStringFormat(@"%zd月",_mouthSelect)];
    }
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCWithdrawRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCWithdrawRecordTableViewCell];
    [cell setupContentWithType:@"提现" time:@"2017-10-10 12:12:12" money:@"-100金币"];
    return cell;
}
#pragma mark 界面

- (void)initializeMainView {
    _yearSelect = -1;
    _mouthSelect = -1;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [mainTableView registerNib:[UINib nibWithNibName:kLCWithdrawRecordTableViewCell bundle:nil] forCellReuseIdentifier:kLCWithdrawRecordTableViewCell];
    mainTableView.rowHeight = 60;
    LCWithdrawRecordHeaderView *searchView = [[LCWithdrawRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchView = searchView;
    mainTableView.tableHeaderView = searchView;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    searchView.searchBlock = ^(NSInteger type, UIImageView *image) {
        [ws headerViewEvent:type param:image];
    };
    
}
- (HSPDefineDatePickView *)datePickView {
    if (!_datePickView) {
        _datePickView = [[HSPDefineDatePickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(ws)
        _datePickView.dateBlock = ^(NSInteger year) {
            [ws changeSearchType:year];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_datePickView];
    }
    return _datePickView;
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
