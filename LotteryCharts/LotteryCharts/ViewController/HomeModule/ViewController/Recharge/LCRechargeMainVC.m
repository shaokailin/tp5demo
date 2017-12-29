//
//  LCRechargeMainVC.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargeMainVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LCRechargeHeaderView.h"
#import "LCRechargePaySureView.h"
#import "LCRechargePayTypeView.h"
#import "LCRechargeMoneyViewModel.h"
#import "LSKActionSheetView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LCRechargeRecordVC.h"
@interface LCRechargeMainVC () {
    NSInteger _selectIndex;
}
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCRechargeHeaderView *headerView;
@property (nonatomic, weak) LCRechargePaySureView *sureView;
@property (nonatomic, weak) LCRechargePayTypeView *typeView;
@property (nonatomic, strong) LCRechargeMoneyViewModel *viewModel;
@end

@implementation LCRechargeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.title = @"充值";
    [self addRightNavigationButtonWithTitle:@"充值记录" target:self action:@selector(rechargeRecord)];
    [self initializeMainView];
    [self bindSignal];
    [self addNotificationWithSelector:@selector(paySuccessCallBack) name:kPay_Success_Notice];
    [self addNotificationWithSelector:@selector(payFailCallBack:) name:kPay_Fail_Notice];
}
- (void)paySuccessCallBack {
    [SKHUD showMessageInWindowWithMessage:@"购买成功"];
    if (_selectIndex >= 0 && self.viewModel.typeArray && self.viewModel.typeArray.count > _selectIndex) {
        LCRechargeMoneyModel *model = [self.viewModel.typeArray objectAtIndex:_selectIndex];
        NSInteger glod = [model.money integerValue];
        NSInteger saveGlod = [kUserMessageManager.money integerValue];
        saveGlod += glod;
        kUserMessageManager.money = NSStringFormat(@"%zd",saveGlod);
        [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kWallet_Change_Notice object:nil];
    }
}
- (void)payFailCallBack:(NSNotification *)notification {
//    NSString *message = [notification.userInfo objectForKey:@"message"];
    [SKHUD showMessageInWindowWithMessage:@"购买失败"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isChangeNavi) {
        [self backToNornalNavigationColor];
    }
}
- (void)pullDownRefresh {
    [self.viewModel getRechargeType];
}
- (void)showActionSheet {
    @weakify(self)
    LSKActionSheetView *actionSheet = [[LSKActionSheetView alloc]initWithCancelButtonTitle:@"取消" clcikIndex:^(NSInteger seletedIndex) {
        if (seletedIndex > 0) {
            @strongify(self)
            self.typeView.payType = seletedIndex - 1;
        }
    } otherButtonTitles:@"微信支付",@"支付宝支付", nil];
    [actionSheet showInView];
}
- (void)selectPayType:(NSInteger)selectIndex {
    if (self.viewModel.typeArray.count > selectIndex) {
        _selectIndex = selectIndex;
        LCRechargeMoneyModel *model = [self.viewModel.typeArray objectAtIndex:selectIndex];
        [self.sureView setupPayTypeWithMoney:model.paymoney number:model.money];
    }
}
- (void)rechargeRecord {
    LCRechargeRecordVC *recordVC = [[LCRechargeRecordVC alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
- (void)payClickWithType:(NSInteger)type {
    if (type == 1) {
        if (_selectIndex >= 0 && self.viewModel.typeArray && self.viewModel.typeArray.count > _selectIndex) {
            LCRechargeMoneyModel *model = [self.viewModel.typeArray objectAtIndex:_selectIndex];
            self.viewModel.jinbi = model.payId;
            [self.sureView setupPayTypeWithMoney:model.paymoney number:model.money];
            [self.viewModel payGlodEventClick];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"请选择要充值"];
        }
    }else {
        [self navigationBackClick];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCRechargeMoneyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self.headerView setupPayMoneyType:self.viewModel.typeArray];
            [self changeHeaderViewFrame];
            [self.mainScrollerView.mj_header endRefreshing];
        }else if (identifier == 10) {
            [self aliPayEvent:model];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier == 0) {
            @strongify(self)
            [self.mainScrollerView.mj_header endRefreshing];
        }
    }];
    [self.viewModel getRechargeType];
}
-(void)changeHeaderViewFrame {
    NSInteger count = self.viewModel.typeArray.count;
    NSInteger hasRow = count / 2 + (count % 2 != 0 ? 1:0);
    CGFloat height = 35 + hasRow * 55 + (hasRow - 1) * 10 + 20;
    if (height < (35 + 55 + 20)) {
        height = 35 + 55 + 20;
    }
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 440 + height);
}
- (void)aliPayEvent:(NSString*)response {
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:response fromScheme:@"lotteryCharts" callback:^(NSDictionary *resultDic) {
        NSInteger code = [[resultDic objectForKey:@"resultStatus"]integerValue];
        if (code == 9000) {
            [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Success_Notice object:nil];
        }else {
//            NSString *memo = [resultDic objectForKey:@"memo"];
//            if (!KJudgeIsNullData(memo)) {
//                memo = @"支付失败";
//            }
            [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kPay_Fail_Notice object:nil];
        }
    }];
}
#pragma mark 界面初始化
- (void)initializeMainView {
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    mainScrollerView.mj_header = refreshHeader;
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    WS(ws)
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    CGFloat contentHeight = 0;
    LCRechargeHeaderView *header = [[LCRechargeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35 + 55 + 20)];
    self.headerView = header;
    [mainScrollerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(35 + 55 + 20);
    }];
    contentHeight += (35 + 55 + 20);
    contentHeight += 10;
    
    LCRechargePayTypeView *typeView = [[[NSBundle mainBundle] loadNibNamed:@"LCRechargePayTypeView" owner:self options:nil] lastObject];
    self.typeView = typeView;
    [mainScrollerView addSubview:typeView];
    
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.top.equalTo(header.mas_bottom).with.offset(10);
        make.height.mas_equalTo(136);
    }];
    
    
    contentHeight += 136;
    contentHeight += 10;
    
    LCRechargePaySureView *sureView = [[[NSBundle mainBundle] loadNibNamed:@"LCRechargePaySureView" owner:self options:nil] lastObject];
    self.sureView = sureView;
    [mainScrollerView addSubview:sureView];
    [sureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.top.equalTo(typeView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(275);
    }];
    contentHeight += 275;
    self.typeView.payType = 1;
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    self.headerView.typeBlock = ^(NSInteger type) {
        [ws selectPayType:type];
    };
    self.typeView.typeBlock = ^(NSInteger type) {
        [ws showActionSheet];
    };
    self.sureView.clickBlock = ^(NSInteger type) {
        [ws payClickWithType:type];
    };
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
