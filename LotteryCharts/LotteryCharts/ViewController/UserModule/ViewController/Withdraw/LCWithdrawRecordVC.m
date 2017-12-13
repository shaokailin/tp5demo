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
    [self bindSignal];
}
- (void)headerViewEvent:(NSInteger)type param:(id)param {
    if (type < 2) {
        _dateSelectType = type;
        self.datePickView.datePickerMode = type;
        [self.datePickView showInView];
    }else {
        _viewModel.year = _yearSelect;
        _viewModel.mouth = _mouthSelect;
        _viewModel.page = 0;
        [_viewModel getWidthdrawRecord:NO];
    }
}

- (void)changeSearchType:(NSInteger)type {
    BOOL isChange = NO;
    if (_dateSelectType == 0) {
        isChange = _yearSelect == type?NO:YES;
        _yearSelect = type;
        [self.searchView setupContentWithLeft:NSStringFormat(@"%zd年",_yearSelect) right:nil];
    }else {
        isChange = _mouthSelect == type?NO:YES;
        _mouthSelect = type;
        [self.searchView setupContentWithLeft:nil right:NSStringFormat(@"%zd月",_mouthSelect)];
    }
    if (isChange) {
        self.viewModel.year = _yearSelect;
        self.viewModel.mouth = _mouthSelect;
        self.viewModel.page = 0;
        [self.viewModel getWidthdrawRecord:NO];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCWithdrawViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self endRefreshing];
        [self.mainTableView reloadData];
        [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:self.viewModel.historyArray.count];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self.viewModel.page == 0) {
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    self.viewModel.year = _yearSelect;
    self.viewModel.mouth = _mouthSelect;
    [self.viewModel getWidthdrawRecord:NO];
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
    [_viewModel getWidthdrawRecord:YES];
}
- (void)pullUpLoadMore {
    _viewModel.page += 1;
    [_viewModel getWidthdrawRecord:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel) {
        return _viewModel.historyArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCWithdrawRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCWithdrawRecordTableViewCell];
    LCWithdrawRecordModel *model = [_viewModel.historyArray objectAtIndex:indexPath.row];
    [cell setupContentWithType:@"提现" time:model.create_time money:model.money];
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
    [self setupSearchInit];
}
- (void)setupSearchInit {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    _yearSelect = comps.year;
    _mouthSelect = comps.month;
    [self.searchView setupContentWithLeft:NSStringFormat(@"%zd年",_yearSelect) right:nil];
    [self.searchView setupContentWithLeft:nil right:NSStringFormat(@"%zd月",_mouthSelect)];
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
