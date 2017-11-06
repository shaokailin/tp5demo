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
#import "PPSSComplaintAdviceVC.h"
#import "PPSSUserHomeMessageModel.h"
#import "PPSSUserHomeViewModel.h"
#import "PPSSWebVC.h"
@interface PPSSPersonHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
    BOOL _isLoadedMessage;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) PPSSPersonHeadView *headerMessageView;
@property (nonatomic, weak) PPSSPersonAssetView *headerAssetView;
@property (nonatomic, strong) PPSSUserHomeViewModel *viewModel;
@end

@implementation PPSSPersonHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self addNotificationWithSelector:@selector(changeUserMessage) name:kUser_Module_Home_Notification];
    [self bindSignal];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isLoadedMessage) {
        _isLoadedMessage = YES;
        [self.viewModel getUserHomeMessageEvent:NO];
    }
}

#pragma mark - method
//用户信息修改
- (void)changeUserMessage {
    if (self.headerMessageView) {
        [self.headerMessageView setupUserPhotoImage:[self userPhotoForPower:[KUserMessageManager.power integerValue]] name:KUserMessageManager.username phone:KUserMessageManager.phone];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSUserHomeViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, PPSSUserHomeMessageModel *model) {
        @strongify(self)
        [self changeUserMessage];
        [self.headerAssetView setupAssetWithBalance:model.totalFee unCash:model.shopFee bankUnCash:model.bankAccountNo];
        if (identifier == 1) {
            [self.mainTableView.mj_header endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier == 1) {
            @strongify(self)
            [self.mainTableView.mj_header endRefreshing];
        }
    }];
}

- (void)pullDownRefresh {
    [self.viewModel getUserHomeMessageEvent:YES];
}
- (UIImage *)userPhotoForPower:(NSInteger)power {
    NSString *imageString = nil;
    switch (power) {
        case 1:
            imageString = @"user_shopmanager";
            break;
        case 2:
            imageString = @"user_cashier";
            break;
        case 3:
            imageString = @"user_administrator";
            break;
            
        default:
            break;
    }
    return ImageNameInit(imageString);
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count + 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 4) {
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
        if (indexPath.row > 4) {
            index --;
        }
        NSDictionary *dict = [_dataArray objectAtIndex:index];
        [cell setupCellContentWithTitle:[dict objectForKey:@"title"] image:[dict objectForKey:@"image"]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 4) {
        return 10;
    }else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        UIViewController *controller = nil;
        switch (indexPath.row) {
            case 1:
            {
                PPSSCashierListVC *cashierListVC = [[PPSSCashierListVC alloc]init];
                controller = cashierListVC;
                break;
            }
            case 2:
            {
                PPSSPersonSettingHomeVC *personSettingHomeVC = [[PPSSPersonSettingHomeVC alloc]init];
                controller = personSettingHomeVC;
                break;
            }
            case 3:
            {
                PPSSWithdrawApplyVC *withdrawApplyVC = [[PPSSWithdrawApplyVC alloc]init];
                controller = withdrawApplyVC;
                break;
            }
            case 5:
            {
                PPSSWebVC *webVC = [[PPSSWebVC alloc]init];
                webVC.title = @"常见问题";
                webVC.loadUrl = kProblemWebUrl;
                controller = webVC;
                break;
            }
            case 6:
            {
                PPSSComplaintAdviceVC *complaintAdviceVC = [[PPSSComplaintAdviceVC alloc]init];
                controller = complaintAdviceVC;
                break;
            }
            case 7:
            {
                PPSSWebVC *webVC = [[PPSSWebVC alloc]init];
                webVC.title = @"关于我们";
                webVC.loadUrl = kAboutUSWebUrl;
                controller = webVC;
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
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,112 + 60 + 44)];
    PPSSPersonHeadView *messageView = [[PPSSPersonHeadView alloc]initWithPersonType:PersonHeaderType_Person];
    self.headerMessageView = messageView;
    [headerView addSubview:messageView];
    [self changeUserMessage];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(112);
    }];
    PPSSPersonAssetView *assetView = [[PPSSPersonAssetView alloc]init];
    self.headerAssetView = assetView;
    [headerView addSubview:assetView];
    [assetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(messageView.mas_bottom);
        make.height.mas_equalTo(60 + 44);
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
