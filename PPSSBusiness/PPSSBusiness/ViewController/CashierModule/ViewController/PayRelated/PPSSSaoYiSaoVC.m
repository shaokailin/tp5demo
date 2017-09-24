//
//  PPSSSaoYiSaoVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSSaoYiSaoVC.h"
#import "PPSSShopCardVC.h"
#import "SGQRCodeScanManager.h"
@interface PPSSSaoYiSaoVC ()<SGQRCodeScanManagerDelegate>
@property (nonatomic, weak) UILabel *moneyLbl;

@end

@implementation PPSSSaoYiSaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kSaoYiSao_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)initializeMainView {
    SGQRCodeScanManager *scanManager = [SGQRCodeScanManager sharedManager];
    
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    
    [scanManager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    
    scanManager.delegate = self;
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    [self.view addSubview:bgView];
    WS(ws)
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    
    UILabel *moneyLble = [LSKViewFactory initializeLableWithText:[self.collectMoney isHasValue]?NSStringFormat(@"￥%@",self.collectMoney):nil font:25 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    self.moneyLbl = moneyLble;
    [bgView addSubview:moneyLble];
    [moneyLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(WIDTH_RACE_6S(60));
        make.centerX.equalTo(bgView);
    }];
    
    UIImageView *scanImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"sys_kuang")];
    [bgView addSubview:scanImg];
    [scanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLble.mas_bottom).with.offset(WIDTH_RACE_6S(41));
        make.centerX.equalTo(bgView);
        make.width.mas_equalTo(407 / 2.0);
    }];
    NSString *lightTitle = @"轻点照亮";
    UIButton *turnLightBtn = [LSKViewFactory initializeButtonWithTitle:lightTitle nornalImage:@"sys_deng" selectedImage:nil target:self action:@selector(turnLightAction) textfont:10 textColor:COLOR_WHITECOLOR backgroundColor:nil backgroundImage:nil];
    CGFloat width = [lightTitle calculateTextWidth:10];
    turnLightBtn.titleEdgeInsets = UIEdgeInsetsMake(34, (width - 60) / 2.0, 0, 5);
    turnLightBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 23, 0, 23);
    [bgView addSubview:turnLightBtn];
    [turnLightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanImg.mas_bottom).with.offset(10);
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    
    UILabel *remarkLbl = [LSKViewFactory initializeLableWithText:@"将顾客付款码放入框内，即可自动扫描" font:10 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    [bgView addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(turnLightBtn.mas_bottom).with.offset(WIDTH_RACE_6S(15));
        make.centerX.equalTo(bgView);
    }];
    
    UIButton *exchangeBtn = [LSKViewFactory initializeButtonWithTitle:@"切换二维码收款" nornalImage:@"sys_qrcode" selectedImage:nil target:self action:@selector(exchangeQRcodeAction) textfont:10 textColor:COLOR_WHITECOLOR backgroundColor:nil backgroundImage:nil];
    ViewRadius(exchangeBtn, 3.0);
    ViewBorderLayer(exchangeBtn, COLOR_WHITECOLOR, LINEVIEW_WIDTH);
    exchangeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    exchangeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    [bgView addSubview:exchangeBtn];
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkLbl.mas_bottom).with.offset(WIDTH_RACE_6S(20));
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(135, 35));
    }];
    
}
- (void)exchangeQRcodeAction {
    PPSSShopCardVC *card = [[PPSSShopCardVC alloc]init];
    [self.navigationController pushViewController:card animated:YES];
}
- (void)turnLightAction {
    
}
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    
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
