//
//  PPSSCashierHomeReusableView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeReusableView.h"

@implementation PPSSCashierHomeReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
        [self _layoutMainView];
    }
    return self;
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
    WS(ws)
    UIView *collectMoneyView = [self _customHeaderBtnView:@"扫码收银" action:@selector(collectMoneyEvent) image:@"smsy_ico"];
    [self addSubview:collectMoneyView];
    [collectMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(58);
        make.top.equalTo (ws).with.offset(34);
        make.size.mas_equalTo(CGSizeMake(112 / 2.0 + 20, 112 / 2.0 + 10 + 16 + 15));
    }];
    UIView *richScanView = [self _customHeaderBtnView:@"扫一扫" action:@selector(richScanEvent) image:@"syssy_ico"];
    [self addSubview:richScanView];
    [richScanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-58);
        make.top.equalTo (ws).with.offset(34);
        make.size.equalTo(collectMoneyView);
    }];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = COLOR_WHITECOLOR;
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"我的资产" font:14 textColor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    [titleView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).with.offset(15);
        make.centerY.equalTo(titleView);
    }];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(44);
    }];
    
}



- (UIView *)_customHeaderBtnView:(NSString *)title action:(SEL)action image:(NSString *)image {
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(5);
        make.centerX.equalTo(view);
        make.width.mas_equalTo(112 / 2.0);
    }];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:title font:15 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    [view addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(15);
        make.centerX.equalTo(imageView);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:tap];
    return view;
}

@end
