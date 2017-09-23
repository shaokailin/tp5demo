//
//  PPSSPersonHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonHomeVC.h"
#import "PPSSPersonHeadView.h"
#import "PPSSPersonAssetView.h"
#import "PPSSPersonFuncTableViewCell.h"
#import "PPSSCashierListVC.h"
#import "PPSSPersonSettingHomeVC.h"
#import "PPSSWithdrawApplyVC.h"
@interface PPSSPersonHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSPersonHeadView *headerMessageView;
@property (nonatomic, weak) PPSSPersonAssetView *headerAssetView;
@end

@implementation PPSSPersonHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count + 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else {
        PPSSPersonFuncTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSPersonFuncTableViewCell];
        NSInteger index = indexPath.row - 1;
        index = indexPath.row > 4 ? index - 1 : index;
        NSDictionary *dict = [_dataArray objectAtIndex:index];
        [cell setupCellContentWithTitle:[dict objectForKey:@"title"] image:[dict objectForKey:@"image"]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        return 10;
    }else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 != 0) {
        NSInteger index = indexPath.row - 1;
        index = indexPath.row > 4 ? index - 1 : index;
        UIViewController *controller = nil;
        switch (index) {
            case 0:
            {
                PPSSCashierListVC *cashierListVC = [[PPSSCashierListVC alloc]init];
                controller = cashierListVC;
                break;
            }
            case 1:
            {
                PPSSPersonSettingHomeVC *personSettingHomeVC = [[PPSSPersonSettingHomeVC alloc]init];
                controller = personSettingHomeVC;
                break;
            }
            case 2:
            {
                PPSSWithdrawApplyVC *withdrawApplyVC = [[PPSSWithdrawApplyVC alloc]init];
                controller = withdrawApplyVC;
                break;
            }
            case 3:
            {
                
                break;
            }
            case 4:
            {
                
                break;
            }
            default:
                break;
        }
        if (controller) {
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}
#pragma mark 界面的初始化
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:@"PersonHome"];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSPersonFuncTableViewCell class] forCellReuseIdentifier:kPPSSPersonFuncTableViewCell];
    self.mainTableView = tableView;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 159 + 95)];
    PPSSPersonHeadView *messageView = [[PPSSPersonHeadView alloc]initWithPersonType:PersonHeaderType_Person];
    self.headerMessageView = messageView;
    [headerView addSubview:messageView];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(159);
    }];
    PPSSPersonAssetView *assetView = [[PPSSPersonAssetView alloc]init];
    self.headerAssetView = assetView;
    [headerView addSubview:assetView];
    [assetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(messageView.mas_bottom);
        make.height.mas_equalTo(95);
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
