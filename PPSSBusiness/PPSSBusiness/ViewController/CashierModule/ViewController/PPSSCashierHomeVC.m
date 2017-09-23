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
@interface PPSSCashierHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSArray *_dataArray;
}
@property (nonatomic, weak) PPSSCashierHomeReusableView *headerView;
@property (nonatomic, weak) UICollectionView *mainCollectionView;
@end

@implementation PPSSCashierHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark - delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPSSCashierHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPPSSCashierHomeCollectionViewCell forIndexPath:indexPath];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *detailString = [dict objectForKey:@"detaititle"];
    if (indexPath.row == 0) {
        detailString = NSStringFormat(@"已收入￥%@",@"121233");
    }
    [cell setupCellContentWithTitle:[dict objectForKey:@"title"] detailTitle:detailString icon: [dict objectForKey:@"icon"]];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.headerView) {
        PPSSCashierHomeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPPSSCashierHomeReusableView forIndexPath:indexPath];
        WS(ws)
        headerView.headerBlock = ^(CashierHomeHeaderEventType type) {
            [ws jumpView:type];
        };
        self.headerView = headerView;
    }
    return self.headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 95 + 129);
}

- (void)jumpView:(CashierHomeHeaderEventType)type {
    UIViewController *controller = nil;
    if (type == CashierHomeHeaderEventType_SaoYiSao) {
        PPSSSaoYiSaoVC *saoyisao = [[PPSSSaoYiSaoVC alloc]init];
        controller = saoyisao;
    }else {
        PPSSCollectMoneyVC *collect = [[PPSSCollectMoneyVC alloc]init];
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
            PPSSIncomeHomeVC *income = [[PPSSIncomeHomeVC alloc]init];
            controller = income;
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
            PPSSNoticeHomeVC *notice = [[PPSSNoticeHomeVC alloc]init];
            controller = notice;
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
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:@"CashierHome"];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 1.0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 1.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 1) / 2.0, 70);
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:nil];
    [collectionView registerClass:[PPSSCashierHomeCollectionViewCell class] forCellWithReuseIdentifier:kPPSSCashierHomeCollectionViewCell];
    [collectionView registerClass:[PPSSCashierHomeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kPPSSCashierHomeReusableView];
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
