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
@interface LCRechargeMainVC ()
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
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isChangeNavi) {
        [self backToNornalNavigationColor];
    }
}
- (void)pullDownRefresh {
    
}
- (void)rechargeRecord {
    
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCRechargeMoneyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self.mainScrollerView.mj_header endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        if (identifier == 0) {
            @strongify(self)
            [self.mainScrollerView.mj_header endRefreshing];
        }
    }];
    [self.viewModel getRechargeType];
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
    LCRechargeHeaderView *header = [[LCRechargeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
    self.headerView = header;
    [mainScrollerView addSubview:header];
    contentHeight += 310;
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
    
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
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
