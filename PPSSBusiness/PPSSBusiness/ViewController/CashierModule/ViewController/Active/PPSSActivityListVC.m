//
//  PPSSActivityListVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityListVC.h"
#import "PPSSActivityListTableViewCell.h"
#import "PPSSActivitySelectTableViewCell.h"
#import "PPSSActivityMessageTableViewCell.h"
#import "PPSSActivityDetailVC.h"
static NSString * const kActivityNamePlistName = @"ActivityName";
@interface PPSSActivityListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_activityTypeArr;
}
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation PPSSActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kActiveList_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark - public
- (void)pullDownRefresh {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullUpLoadMore {
    [self.mainTableView.mj_footer endRefreshing];
}
- (void)addActivityAction:(PPSSActivityMessageTableViewCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    PPSSActivityDetailVC *detailVC = [[PPSSActivityDetailVC alloc]init];
    detailVC.type = ActivityDetailType_Add;
    detailVC.activityType = indexPath.row;
    NSDictionary *dict = [_activityTypeArr objectAtIndex:indexPath.row];
    detailVC.activityTitle = [dict objectForKey:@"title"];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)showListType:(NSInteger)type {
    
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activityTypeArr.count + 1 + 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _activityTypeArr.count) {
        PPSSActivityMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityMessageTableViewCell];
        NSDictionary *dict = [_activityTypeArr objectAtIndex:indexPath.row];
        [cell setupContentWithTitle:[dict objectForKey:@"title"] detail:[dict objectForKey:@"detail"] icon:[dict objectForKey:@"icon"]];
        WS(ws)
        cell.addBlock = ^(PPSSActivityMessageTableViewCell *clickCell) {
            [ws addActivityAction:clickCell];
        };
        return cell;
    }else if (indexPath.row == _activityTypeArr.count) {
        PPSSActivitySelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivitySelectTableViewCell];
        WS(ws)
        cell.selectBlock = ^(NSInteger type) {
            [ws showListType:type];
        };
        return cell;
    }else {
        PPSSActivityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSActivityListTableViewCell];
        NSInteger index = (indexPath.row - _activityTypeArr.count - 1) % 4;
        [cell setupContentWithTime:@"2017-12-12 12:12:12" remark:@"介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍" count:@"5000" money:@"12312.00" type:index progress:0.58];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 4) {
        return 80;
    }else if (indexPath.row == 4) {
        return 50;
    }else {
        return 118;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 4) {
        NSInteger index = (indexPath.row - _activityTypeArr.count - 1) % 4;
        PPSSActivityDetailVC *detailVC = [[PPSSActivityDetailVC alloc]init];
        detailVC.type = ActivityDetailType_Exit;
        detailVC.activityType = index;
        NSDictionary *dict = [_activityTypeArr objectAtIndex:index];
        detailVC.activityTitle = [dict objectForKey:@"title"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (void)initializeMainView {
    _activityTypeArr = [NSArray arrayWithPlist:kActivityNamePlistName];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSActivityListTableViewCell class] forCellReuseIdentifier:kPPSSActivityListTableViewCell];
    [tableView registerClass:[PPSSActivitySelectTableViewCell class] forCellReuseIdentifier:kPPSSActivitySelectTableViewCell];
    [tableView registerClass:[PPSSActivityMessageTableViewCell class] forCellReuseIdentifier:kPPSSActivityMessageTableViewCell];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
