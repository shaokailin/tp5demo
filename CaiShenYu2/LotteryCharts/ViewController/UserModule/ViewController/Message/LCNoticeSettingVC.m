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
@interface LCNoticeSettingVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTable;
@end

@implementation LCNoticeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息设置";
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self initializeMainView];
}

- (void)pullDownRefresh {
     [self.mainTable.mj_header endRefreshing];
}
- (void)changeNoticeClick:(LCNoticeSettingCell *)cell state:(BOOL)state {
    NSInteger index = [self.mainTable indexPathForCell:cell].row;
    LSKLog(@"%ld---%d",index,state);
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
        [cell setupCellContent:[self returnTitleString:indexPath.row] state:indexPath.row % 2 == 0];
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
