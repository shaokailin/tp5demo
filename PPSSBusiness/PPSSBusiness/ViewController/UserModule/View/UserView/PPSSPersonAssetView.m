//
//  PPSSPersonAssetView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonAssetView.h"
@interface PPSSPersonAssetView()
@property (nonatomic, weak) UILabel *balanceLbl;
@property (nonatomic, weak) UILabel *unCashLbl;
@property (nonatomic, weak) UILabel *bankUnCashLbl;
@end
@implementation PPSSPersonAssetView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        [self _layoutMainView];
    }
    return self;
}
#pragma mark - public
- (void)setupAssetWithBalance:(NSString *)balance unCash:(NSString *)unCash bankUnCash:(NSString *)bankUnCash {
    _balanceLbl.text = balance;
    _bankUnCashLbl.text = bankUnCash;
    _unCashLbl.text = unCash;
}
#pragma mark - 界面
- (void)_layoutMainView {
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [self addSubview:lineView];
    WS(ws)
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(ws).with.offset(44);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"我的资产" textAlignment:0];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(15);
        make.top.equalTo(ws);
        make.bottom.equalTo(lineView.mas_top);
    }];
    
    UILabel *balanceTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:0] textAlignment:1];
    
    [self addSubview:balanceTitleLbl];
    UILabel *balanceLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    self.balanceLbl = balanceLbl;
    [self addSubview:balanceLbl];
    
    UILabel *unCashTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:2] textAlignment:1];
    [self addSubview:unCashTitleLbl];
    UILabel *unCashLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    self.unCashLbl = unCashLbl;
    [self addSubview:unCashLbl];
    
    UILabel *bankUnCashTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:3] textAlignment:1];
    [self addSubview:bankUnCashTitleLbl];
    UILabel *bankUnCashLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    self.bankUnCashLbl = bankUnCashLbl;
    [self addSubview:bankUnCashLbl];
    
    [balanceTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.top.equalTo(lineView.mas_bottom).with.offset(8);
    }];
    [balanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).with.offset(-7);
        make.left.right.equalTo(balanceTitleLbl);
    }];
    
    [unCashTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(balanceTitleLbl.mas_right);
        make.top.equalTo(balanceTitleLbl);
        make.width.equalTo(balanceTitleLbl);
    }];
    [unCashLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(balanceLbl);
        make.left.right.equalTo(unCashTitleLbl);
    }];
    [bankUnCashTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unCashTitleLbl.mas_right);
        make.right.equalTo(ws);
        make.width.equalTo(unCashTitleLbl);
        make.top.equalTo(balanceTitleLbl);
    }];
    [bankUnCashLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(balanceLbl);
        make.left.right.equalTo(bankUnCashTitleLbl);
    }];
}
- (NSString *)returnTitleWithIndex:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"总营业额";
            break;
        case 1:
            title = @"净收入";
            break;
        case 2:
            title = @"账户余额";
            break;
            
        default:
            title = @"待银行清算";
            break;
    }
    return title;
}
@end
