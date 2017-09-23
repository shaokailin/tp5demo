//
//  PPSSCashierHomeReusableView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeReusableView.h"

@implementation PPSSCashierHomeReusableView{
    UILabel *_collectionMoneyLbl;
    UILabel *_collectionCountLbl;
    UILabel *_addMemberCountLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCashierContentWithMoney:(NSString *)money count:(NSString *)count addMember:(NSString *)member {
    _collectionMoneyLbl.text = money;
    _collectionCountLbl.text = count;
    _addMemberCountLbl.text = member;
}
#pragma mark 私有
- (void)collectMoneyEvent {
    if (self.headerBlock) {
        self.headerBlock(CashierHomeHeaderEventType_CollectMoney);
    }
}
- (void)richScanEvent {
    if (self.headerBlock) {
        self.headerBlock(CashierHomeHeaderEventType_SaoYiSao);
    }
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"cashier_headerbg")];
    [self addSubview:bgImageView];
    WS(ws)
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(129);
    }];
    UIView *collectMoneyView = [self _customHeaderBtnView:@"收银" action:@selector(collectMoneyEvent) image:@"shouyin_ico"];
    [self addSubview:collectMoneyView];
    [collectMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(58);
        make.top.equalTo (ws).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(132 / 2.0 + 10, 132 / 2.0 + 10 + 22 + 10));
    }];
    UIView *richScanView = [self _customHeaderBtnView:@"扫一扫" action:@selector(richScanEvent) image:@"cashier_saoyisao"];
    [self addSubview:richScanView];
    [richScanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-58);
        make.top.equalTo (ws).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(132 / 2.0 + 10, 132 / 2.0 + 10 + 22 + 10));
    }];
    
    [self _layoutMoneyView];
}



- (UIView *)_customHeaderBtnView:(NSString *)title action:(SEL)action image:(NSString *)image {
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(5);
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(132 / 2.0, 132 / 2.0));
    }];
    
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:nil action:nil textfont:12 textColor:ColorHexadecimal(Color_APP_MAIN, 1.0) backgroundColor:COLOR_WHITECOLOR backgroundImage:nil];
    ViewRadius(btn, 3.0);
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 22));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:tap];
    return view;
}
- (void)_layoutMoneyView {
    UIView *todayDataView = [[UIView alloc]init];
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [todayDataView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(todayDataView);
        make.top.equalTo(todayDataView).with.offset(44);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"今日数据" font:12 textColor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    [todayDataView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(todayDataView).with.offset(15);
        make.top.equalTo(todayDataView);
        make.bottom.equalTo(lineView.mas_top);
    }];
    
    UILabel *collectionMoneyTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:0] textAlignment:1];
    
    [todayDataView addSubview:collectionMoneyTitleLbl];
    UILabel *collectionMoneyLbl = [PPSSPublicViewManager initLblForColorPink:@"0.00" textAlignment:1];
    _collectionMoneyLbl = collectionMoneyLbl;
    [todayDataView addSubview:collectionMoneyLbl];
    
    UILabel *collectionCountTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:1] textAlignment:1];
    [todayDataView addSubview:collectionCountTitleLbl];
    UILabel *collectionCountLbl = [PPSSPublicViewManager initLblForColorPink:@"0" textAlignment:1];
    _collectionCountLbl = collectionCountLbl;
    [todayDataView addSubview:collectionCountLbl];
    
    UILabel *addMemberCountTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:2] textAlignment:1];
    [todayDataView addSubview:addMemberCountTitleLbl];
    UILabel *addMemberCountLbl = [PPSSPublicViewManager initLblForColorPink:@"0" textAlignment:1];
    _addMemberCountLbl = addMemberCountLbl;
    [todayDataView addSubview:addMemberCountLbl];
    
    
    [collectionMoneyTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(todayDataView);
        make.top.equalTo(lineView.mas_bottom).with.offset(8);
    }];
    [collectionMoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(todayDataView).with.offset(-7);
        make.left.right.equalTo(collectionMoneyTitleLbl);
    }];
    [collectionCountTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectionMoneyTitleLbl.mas_right);
        make.top.equalTo(collectionMoneyTitleLbl);
        make.width.equalTo(collectionMoneyTitleLbl);
    }];
    [collectionCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectionMoneyLbl);
        make.left.right.equalTo(collectionCountTitleLbl);
    }];
    
    [addMemberCountTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectionCountTitleLbl.mas_right);
        make.top.equalTo(collectionMoneyTitleLbl);
        make.right.equalTo(todayDataView);
        make.width.equalTo(collectionCountTitleLbl);
    }];
    [addMemberCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectionMoneyLbl);
        make.left.right.equalTo(addMemberCountTitleLbl);
    }];
    
    [self addSubview:todayDataView];
    WS(ws)
    [todayDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(95);
    }];
}
- (NSString *)returnTitleWithIndex:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"收款金额";
            break;
        case 1:
            title = @"收款笔数";
            break;
        default:
            title = @"新增会员";
            break;
    }
    return title;
}
@end
