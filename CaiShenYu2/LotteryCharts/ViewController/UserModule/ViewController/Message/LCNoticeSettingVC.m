//
//  LCNoticeSettingVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCNoticeSettingVC.h"
#import "LCNoticeSettingCell.h"
#import "LCSpaceTableViewCell.h"
#import "LCMessageListVM.h"
@interface LCNoticeSettingVC ()<UITableViewDelegate, UITableViewDataSource>
{
    LCMessageListVM *_viewModel;
    BOOL _isChange;
}
@property (nonatomic, weak) UITableView *mainTable;
@end

@implementation LCNoticeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息设置";
    [self addRedNavigationBackButton];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self bindSignal];
    [self initializeMainView];
}
- (void)backToWhiteNavigationColor {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : ColorRGBA(230, 0, 18, 1.0),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isChange){
        [self backToWhiteNavigationColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isChange = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorUtilsString(kNavigationTitle_Color),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
    [self backToNornalNavigationColor];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCMessageListVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.mainTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->_viewModel.type inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSUInteger identifier, NSError *error) {
        
    }];
    _viewModel.model = self.model;
}
- (void)pullDownRefresh {
     [self.mainTable.mj_header endRefreshing];
}
- (void)changeNoticeClick:(LCNoticeSettingCell *)cell state:(BOOL)state {
    NSInteger index = [self.mainTable indexPathForCell:cell].row;
    _viewModel.type = index;
    _viewModel.changeValue = !state;
    [_viewModel changeUserSetting];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else {
        LCNoticeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCNoticeSettingCell];
        [cell setupCellContent:[self returnTitleString:indexPath.row] state:[self returnValue:indexPath.row]];
        @weakify(self)
        cell.clickBlock = ^(id clickCell,BOOL state) {
            @strongify(self)
            [self changeNoticeClick:clickCell state:state];
        };
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 10;
    }else {
        return 46;
    }
}
- (BOOL)returnValue:(NSInteger)index {
    BOOL value = YES;
    switch (index) {
        case 0:
            value = _viewModel.model.comment_reply;
            break;
        case 1:
            value = _viewModel.model.reward;
            break;
        case 2:
            value = _viewModel.model.focus;
            break;
        case 4:
            value = _viewModel.model.system;
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)returnTitleString:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"评论与回复";
            break;
        case 1:
            title = @"打赏消息";
            break;
        case 2:
            title = @"关注消息";
            break;
        case 4:
            title = @"系统消息";
            break;
            
        default:
            break;
    }
    return title;
}
- (void)initializeMainView {
    UITableView *tableVIew = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    tableVIew.allowsSelection = NO;
    UILabel *headerView = [LSKViewFactory initializeLableWithText:@"    @我的" font:13 textColor:ColorHexadecimal(0x888888, 1.0) textAlignment:0 backgroundColor:nil];
    headerView.frame = CGRectMake(15, 0, 100, 32);
    tableVIew.tableHeaderView = headerView;
    
    UILabel *footerView = [LSKViewFactory initializeLableWithText:@"    关闭后，将不再提醒新通知" font:13 textColor:ColorHexadecimal(0x888888, 1.0) textAlignment:0 backgroundColor:nil];
    footerView.frame = CGRectMake(15, 0, 100, 32);
    tableVIew.tableFooterView = footerView;
    
    self.mainTable = tableVIew;
    [tableVIew registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    [tableVIew registerNib:[UINib nibWithNibName:kLCNoticeSettingCell bundle:nil] forCellReuseIdentifier:kLCNoticeSettingCell];
    [self.view addSubview:tableVIew];
    [tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0.0));
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
