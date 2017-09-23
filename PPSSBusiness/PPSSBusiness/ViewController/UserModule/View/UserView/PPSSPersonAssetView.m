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
@property (nonatomic, weak) UILabel *incomeLbl;
@property (nonatomic, weak) UILabel *bankHasCashLbl;
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
- (void)setupAssetWithBalance:(NSString *)balance income:(NSString *)income bankHasCash:(NSString *)bankHasCash bankUnCash:(NSString *)bankUnCash {
    _balanceLbl.text = balance;
    _incomeLbl.text = income;
    _bankUnCashLbl.text = bankUnCash;
    _bankHasCashLbl.text = bankHasCash;
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
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"我的资产" font:12 textColor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
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
    
    UILabel *incomeTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:1] textAlignment:1];
    [self addSubview:incomeTitleLbl];
    UILabel *incomeLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    self.incomeLbl = incomeLbl;
    [self addSubview:incomeLbl];
    
    UILabel *bankHasCashTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:2] textAlignment:1];
    [self addSubview:bankHasCashTitleLbl];
    UILabel *bankHasCashLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    self.bankHasCashLbl = bankHasCashLbl;
    [self addSubview:bankHasCashLbl];
    
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
    [incomeTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(balanceTitleLbl.mas_right);
        make.top.equalTo(balanceTitleLbl);
        make.width.equalTo(balanceTitleLbl);
    }];
    [incomeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(balanceLbl);
        make.left.right.equalTo(incomeTitleLbl);
    }];
    
    [bankHasCashTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(incomeTitleLbl.mas_right);
        make.top.equalTo(balanceTitleLbl);
        make.width.equalTo(incomeTitleLbl);
    }];
    [bankHasCashLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(balanceLbl);
        make.left.right.equalTo(bankHasCashTitleLbl);
    }];
    [bankUnCashTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankHasCashTitleLbl.mas_right);
        make.right.equalTo(ws);
        make.width.equalTo(bankHasCashTitleLbl);
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
            title = @"商户余额";
            break;
        case 1:
            title = @"净收入";
            break;
        case 2:
            title = @"银行已清算";
            break;
            
        default:
            title = @"银行待清算";
            break;
    }
    return title;
}
@end
