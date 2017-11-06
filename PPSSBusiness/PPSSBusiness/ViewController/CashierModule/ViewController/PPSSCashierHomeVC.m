//
//  PPSSCashierHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeVC.h"
#import "PPSSCashierHomeReusableView.h"
#import "PPSSCashierHomeCollectionViewCell.h"
#import "PPSSNoticeHomeVC.h"
#import "PPSSMemberListVC.h"
#import "PPSSShopCardVC.h"
#import "PPSSSaoYiSaoVC.h"
#import "PPSSIncomeHomeVC.h"
#import "PPSSActivityListVC.h"
#import "PPSSCollectMoneyVC.h"
#import "LSKImageManager.h"
#import <AVFoundation/AVFoundation.h>
#import "PPSSCashierHomeFooterReusableView.h"
#import "PPSSCashierHomeViewModel.h"
#import "PPSSWebVC.h"
#import <JPUSHService.h>
#import "PPSSWithdrawApplyVC.h"
#import "PPSSPersonSettingHomeVC.h"
#import "PPSSPunchCardRecordVC.h"
@interface PPSSCashierHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSArray *_dataArray;
}
@property (nonatomic, weak) PPSSCashierHomeReusableView *headerView;
@property (nonatomic, weak) PPSSCashierHomeFooterReusableView *footerView;
@property (nonatomic, weak) UICollectionView *mainCollectionView;
@property (nonatomic, strong) PPSSCashierHomeViewModel *viewModel;
@end
static BOOL isHasLoadHome = NO;
@implementation PPSSCashierHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeMainView];
    [self bindSignal];
    [self addNotificationWithSelector:@selector(getUserMessage) name:kCashier_Module_Home_Notification];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!isHasLoadHome && !KUserMessageManager.loginModel) {
        isHasLoadHome = YES;
        [_viewModel getUserMessageByToken:NO];
    }else if(KUserMessageManager.loginModel) {
        isHasLoadHome = YES;
        _viewModel.userMessageModel = KUserMessageManager.loginModel;
        KUserMessageManager.loginModel = nil;
        [self setupFootViewData];
    }
    [_footerView viewDidAppearForBanner];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_footerView viewDidDisAppearForBanner];
}
- (void)getUserMessage {
    [self.mainCollectionView reloadData];
    [self addRightNaviBtn];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSCashierHomeViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (self.viewModel.isPull) {
            [self.mainCollectionView.mj_header endRefreshing];
        }
        [self setupFootViewData];
        
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        
        if (self.viewModel.isPull) {
            [self.mainCollectionView.mj_header endRefreshing];
        }else {
            isHasLoadHome = NO;
        }
    }];
}
- (void)setupFootViewData {
    [self.footerView setupCashierContentWithMoney:self.viewModel.userMessageModel.incomeMoney count:self.viewModel.userMessageModel.incomeNumber addMember:self.viewModel.userMessageModel.members];
    [self.footerView setupBannersImageArray:self.viewModel.userMessageModel.banners];
}
- (void)pullDownRefresh {
    [self addRightNaviBtn];
    [_viewModel getUserMessageByToken:YES];
}
#pragma mark - delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPSSCashierHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPPSSCashierHomeCollectionViewCell forIndexPath:indexPath];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    NSString *detailString = [dict objectForKey:@"detaititle"];
    if (indexPath.row == 0 && [KUserMessageManager.power integerValue] == 2) {
        title = @"余额提现";
        detailString = @"";
    }
    [cell setupCellContentWithTitle:title detailTitle:detailString icon: [dict objectForKey:@"icon"]];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([KUserMessageManager.power integerValue] == 2) {
        return _dataArray.count;
    }else {
        return _dataArray.count - 2;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (!self.headerView) {
            PPSSCashierHomeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPPSSCashierHomeReusableView forIndexPath:indexPath];
            WS(ws)
            headerView.headerBlock = ^(CashierHomeHeaderEventType type) {
                [ws jumpView:type];
            };
            self.headerView = headerView;
        }
        return self.headerView;
    }else {
        if (!self.footerView) {
            PPSSCashierHomeFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kPPSSCashierHomeFooterReusableView forIndexPath:indexPath];
            @weakify(self)
            footerView.clickBlock = ^(NSInteger index) {
              @strongify(self)
                [self jumpWebViewWithIndex:index];
            };
            footerView.btnBlock = ^(NSInteger type) {
                @strongify(self)
                if (type == 1) {
                    PPSSNoticeHomeVC *notice = [[PPSSNoticeHomeVC alloc]init];
                    notice.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:notice animated:YES];
                }else {
                    PPSSPersonSettingHomeVC *setting = [[PPSSPersonSettingHomeVC alloc]init];
                    setting.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:setting animated:YES];
                }
            };
            self.footerView = footerView;
        }
        [self.footerView showSettingView:[KUserMessageManager.power integerValue] == 2];
        return self.footerView;
    }
}
- (void)jumpWebViewWithIndex:(NSInteger)index {
    if (KJudgeIsArrayAndHasValue(self.viewModel.userMessageModel.banners) &&  self.viewModel.userMessageModel.banners.count > index) {
        PPSSBannerModel *model = [self.viewModel.userMessageModel.banners objectAtIndex:index];
        if (KJudgeIsNullData(model.link)) {
            PPSSWebVC *webVC = [[PPSSWebVC alloc]init];
            webVC.titleString = model.title;
            webVC.loadUrl = model.link;
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 154 + 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 44 + 2 + 60 + WIDTH_RACE_6S(75) + 44 + 20 + ([KUserMessageManager.power integerValue] == 2 ? 44 + 10 : 0));
}

- (void)jumpView:(CashierHomeHeaderEventType)type {
    UIViewController *controller = nil;
    if (type == CashierHomeHeaderEventType_SaoYiSao) {
        @weakify(self)
        [LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            @strongify(self)
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    PPSSSaoYiSaoVC *saoyisao = [[PPSSSaoYiSaoVC alloc]init];
                    saoyisao.inType = CollectMoneyInType_SaoYiSao;
                    saoyisao.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:saoyisao animated:YES];
                });
            }
        }];
        
    }else {
        PPSSCollectMoneyVC *collect = [[PPSSCollectMoneyVC alloc]init];
        collect.inType = CollectMoneyInType_Input;
        controller = collect;
    }
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:
        {
            if ([KUserMessageManager.power integerValue] == 2) {
                PPSSWithdrawApplyVC *withdraw = [[PPSSWithdrawApplyVC alloc]init];
                controller = withdraw;
            }else {
                PPSSIncomeHomeVC *income = [[PPSSIncomeHomeVC alloc]init];
                controller = income;
            }
            break;
        }
        case 1:
        {
            PPSSShopCardVC *card = [[PPSSShopCardVC alloc]init];
            controller = card;
            break;
        }
        case 2:
        {
            PPSSActivityListVC *activity = [[PPSSActivityListVC alloc]init];
            controller = activity;
            break;
        }
        case 3:
        {
            PPSSMemberListVC *member = [[PPSSMemberListVC alloc]init];
            controller = member;
            break;
        }
        case 4:
        {
            
            break;
        }
        case 5:
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
#pragma mark - 界面初始化
- (void)addRightNaviBtn {
    NSInteger power = [KUserMessageManager.power integerValue];
    if ([self isHasRightNavigation] && power != 2) {
        [self addRightNavigationButtonWithNornalImage:@"cashier_rili" seletedIamge:@"cashier_rili" target:self action:@selector(showSignInView)];
    }else if(![self isHasRightNavigation] && power == 2) {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItems = nil;
    }
}
- (BOOL)isHasRightNavigation {
    if ([LSKPublicMethodUtil getiOSSystemVersion] >= 11) {
        return self.navigationItem.rightBarButtonItem == nil;
    }else {
       return self.navigationItem.rightBarButtonItems == nil;
    }
}
- (void)showSignInView {
    PPSSPunchCardRecordVC *punchCardVC = [[PPSSPunchCardRecordVC alloc]init];
    punchCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:punchCardVC animated:YES];
}
- (void)initializeMainView {
    [self addRightNaviBtn];
    _dataArray = [NSArray arrayWithPlist:@"CashierHome"];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 1.0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 1.0;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 10, 0);
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 1) / 2.0, 70);
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:nil];
    [collectionView registerClass:[PPSSCashierHomeCollectionViewCell class] forCellWithReuseIdentifier:kPPSSCashierHomeCollectionViewCell];
    [collectionView registerClass:[PPSSCashierHomeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPPSSCashierHomeReusableView];
    [collectionView registerClass:[PPSSCashierHomeFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kPPSSCashierHomeFooterReusableView];
    self.mainCollectionView = collectionView;
    [self.view addSubview:collectionView];
    WS(ws)
    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
