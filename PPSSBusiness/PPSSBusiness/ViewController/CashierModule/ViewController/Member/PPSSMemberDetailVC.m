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
#import "PPSSMemberDetailViewModel.h"
#import "TPKeyboardAvoidingTableView.h"
#import "PPSSComplaintAdviceVC.h"
static NSString * const kMemberDetailPlistName = @"MemberDetailTitle";
@interface PPSSMemberDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, copy) NSString *remarkText;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, weak) PPSSPersonHeadView *headerMessageView;
@property (nonatomic, strong) PPSSMemberDetailViewModel *viewModel;
@end

@implementation PPSSMemberDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kMemberDetail_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
#pragma mark public
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSMemberDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
       [self.headerMessageView setupUserPhoto:self.viewModel.memberDetailModel.userAvatar name:self.viewModel.memberDetailModel.userName phone:self.viewModel.memberDetailModel.userPhone];
        [self.headerMessageView setupMessageWithConsumeCount:self.viewModel.memberDetailModel.userTimes integral:self.viewModel.memberDetailModel.userScore returnCash:self.viewModel.memberDetailModel.userStore];
        self.remarkText = self.viewModel.memberDetailModel.remark;
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    self.viewModel.userId = self.userId;
    [self.viewModel getMemberDetail:NO];
}
- (void)pullDownRefresh {
    [self.viewModel getMemberDetail:YES];
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftString = [_dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 4) {
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
       [cell setupContentWithLeft:leftString remark:self.remarkText];
        return cell;
    }else {
        PPSSMemberDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSMemberDetailTableViewCell];
        NSInteger type = indexPath.row < 3 ? 2:1;
        [cell setupContentWithLeft:leftString right:[self returnRightContent:indexPath.row] type:type];
        return cell;
    }
}
- (NSString *)returnRightContent:(NSInteger)row {
    if (self.viewModel && self.viewModel.memberDetailModel) {
        NSString * title = nil;
        switch (row) {
            case 0:
                title = NSStringFormat(@"￥%@",KNullTransformMoney(self.viewModel.memberDetailModel.feeAverage));
                break;
            case 1:
                title = NSStringFormat(@"￥%@",KNullTransformMoney(self.viewModel.memberDetailModel.feeTotal));
                break;
            case 2:
                title = self.viewModel.memberDetailModel.LastTime;
                break;
            case 3:
                title = self.viewModel.memberDetailModel.createTime;
                break;
            case 5:
                title = self.viewModel.memberDetailModel.userBirth;
                break;
            case 6:
                title = self.viewModel.memberDetailModel.userArea;
                break;
            default:
                break;
        }
        return title;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 10;
    }else if (indexPath.row == _dataArray.count - 1) {
        CGFloat height = KJudgeIsNullData(self.remarkText)? [self.remarkText calculateTextHeight:12 width:SCREEN_WIDTH - 30 - 10]: 0;
        if (height < 100) {
            height = 100;
        }
        return 44 + 20 + height;
        
    }else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _dataArray.count - 1) {
        PPSSComplaintAdviceVC *remarkVC = [[PPSSComplaintAdviceVC alloc]init];
        remarkVC.type = InControllerType_Remark;
        remarkVC.userId = self.userId;
        WS(ws)
        remarkVC.remarkBlock = ^(NSString *remark) {
            ws.remarkText = remark;
            [ws.mainTableView exitTableViewWithType:LSKTableViewExitType_Reload indexPathStart:_dataArray.count - 1 indexPathEnd:_dataArray.count - 1 section:0 animation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:remarkVC animated:YES];
    }
}
#pragma mark 界面的初始化
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:kMemberDetailPlistName];
    TPKeyboardAvoidingTableView *tableView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tableView registerClass:[PPSSMemberDetailTableViewCell class] forCellReuseIdentifier:kPPSSMemberDetailTableViewCell];
    [tableView registerClass:[PPSSMemberDetailRemarkTableViewCell class] forCellReuseIdentifier:kPPSSMemberDetailRemarkTableViewCell];
    self.mainTableView = tableView;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112 + 54)];
    PPSSPersonHeadView *messageView = [[PPSSPersonHeadView alloc]initWithPersonType:PersonHeaderType_Member];
    self.headerMessageView = messageView;
    [headerView addSubview:messageView];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo( 112 + 54);
    }];
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
