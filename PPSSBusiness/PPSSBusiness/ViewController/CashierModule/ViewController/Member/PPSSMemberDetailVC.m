//
//  PPSSMemberDetailVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberDetailVC.h"
#import "PPSSPersonHeadView.h"
#import "PPSSPersonAssetView.h"
#import "PPSSMemberDetailTableViewCell.h"
#import "PPSSMemberDetailRemarkTableViewCell.h"
static NSString * const kMemberDetailPlistName = @"MemberDetailTitle";
@interface PPSSMemberDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSPersonHeadView *headerMessageView;
@end

@implementation PPSSMemberDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kMemberDetail_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark public
- (void)pullDownRefresh {
    
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftString = [_dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 5) {
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else if (indexPath.row == _dataArray.count - 1) {
        PPSSMemberDetailRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSMemberDetailRemarkTableViewCell];
        [cell setupContentWithLeft:leftString remark:@"阳光，帅气，有内涵"];
        return cell;
    }else {
        PPSSMemberDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSMemberDetailTableViewCell];
        NSInteger type = indexPath.row < 3 ? 2:1;
        [cell setupContentWithLeft:leftString right:@"text" type:type];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) {
        return 10;
    }else if (indexPath.row == _dataArray.count - 1) {
        CGFloat width = 34 + 10;
        return 44 + (width > 44 ? width : 44);
    }else {
        return 44;
    }
}
#pragma mark 界面的初始化
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:kMemberDetailPlistName];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSMemberDetailTableViewCell class] forCellReuseIdentifier:kPPSSMemberDetailTableViewCell];
    [tableView registerClass:[PPSSMemberDetailRemarkTableViewCell class] forCellReuseIdentifier:kPPSSMemberDetailRemarkTableViewCell];
    self.mainTableView = tableView;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 159)];
    PPSSPersonHeadView *messageView = [[PPSSPersonHeadView alloc]initWithPersonType:PersonHeaderType_Member];
    self.headerMessageView = messageView;
    [headerView addSubview:messageView];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(159);
    }];
    tableView.tableHeaderView = headerView;
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
