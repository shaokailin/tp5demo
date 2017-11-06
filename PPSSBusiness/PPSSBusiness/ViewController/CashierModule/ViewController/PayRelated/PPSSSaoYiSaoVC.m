//
//  PPSSSaoYiSaoVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSSaoYiSaoVC.h"
#import "PPSSShopCardVC.h"
#import <AVFoundation/AVFoundation.h>
#import "PPSSPayMoneyViewModel.h"
#import "PPSSCollectMoneyVC.h"
@interface PPSSSaoYiSaoVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, weak) UILabel *moneyLbl;
@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * session;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, assign) BOOL isTurnOnLight;
@property (nonatomic, strong) PPSSPayMoneyViewModel *viewModel;
@property (nonatomic, weak) UIImageView *lineView;
@property (nonatomic, strong) CABasicAnimation * animaiton;
@end

@implementation PPSSSaoYiSaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kSaoYiSao_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startRunning];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self endRunning];
}
#pragma mark 扫码处理
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (_isStart) {
        [self endRunning];
        NSString *stringValue = nil;
        if ([metadataObjects count] >0) {
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
            stringValue = metadataObject.stringValue;
        }
        LSKLog(@"%@",stringValue);
        if ([self isAvailableAliPay:stringValue] || [self isAvailableWechatPay:stringValue]) {
            [self handleQRcodeEvent:stringValue];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"请扫微信或者支付宝用户的付款码~!"];
            [self performSelector:@selector(startRunning) withObject:nil afterDelay:1.2];
        }
    }
}
- (void)handleQRcodeEvent:(NSString *)text {
    if (_inType == CollectMoneyInType_SaoYiSao) {
        PPSSCollectMoneyVC *collect = [[PPSSCollectMoneyVC alloc]init];
        collect.inType = CollectMoneyInType_SaoYiSao;
        collect.qrCodeString = text;
        [self.navigationController pushViewController:collect animated:YES];
    }else {
        self.viewModel.qcode = text;
        [self.viewModel payMoneyEvent];
    }
}

- (BOOL)isAvailableAliPay:(NSString *)text {
    if (KJudgeIsNullData(text)) {
        NSString *alipayRegex = @"^(2[5-9]|30)[0-9]{14,22}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",alipayRegex];
        return [predicate evaluateWithObject:text];
    }
    return false;
}
- (BOOL)isAvailableWechatPay:(NSString *)text {
    if (KJudgeIsNullData(text)) {
        NSString *wechatRegex = @"^(1[0-5])[0-9]{16}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",wechatRegex];
        return [predicate evaluateWithObject:text];
    }
    return false;
}
- (void)startRunning {
    if (!_isStart) {
        self.lineView.frame = CGRectMake((SCREEN_WIDTH - 298 / 2.0) / 2.0, WIDTH_RACE_6S(86) + 22, 298 / 2.0, 3);
        [self.lineView.layer addAnimation:self.animaiton forKey:@"position"];
        _isStart = YES;
        [_session startRunning];
    }
}
- (void)endRunning {
    if (_isStart) {
        [self.lineView.layer removeAllAnimations];
        self.lineView.frame = CGRectMake((SCREEN_WIDTH - 298 / 2.0) / 2.0, WIDTH_RACE_6S(86) + 22, 298 / 2.0, 0);
        _isStart = NO;
        [_session stopRunning ];
    }
}
- (CABasicAnimation *)animaiton {
    if (!_animaiton) {
        _animaiton = [CABasicAnimation animationWithKeyPath:@"position"];
        _animaiton.removedOnCompletion = NO;
        _animaiton.fillMode = kCAFillModeBackwards;
        _animaiton.duration = 2;
        _animaiton.repeatCount = MAXFLOAT;
        _animaiton.toValue = [NSValue valueWithCGPoint:CGPointMake((SCREEN_WIDTH / 2.0), WIDTH_RACE_6S(86) + 22 + 204)];
    }
    return _animaiton;
}

- (PPSSPayMoneyViewModel *)viewModel {
    if (!_viewModel) {
        @weakify(self)
        _viewModel = [[PPSSPayMoneyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
            [self performSelector:@selector(backToHome) withObject:nil afterDelay:1.2];
        } failure:^(NSUInteger identifier, NSError *error) {
            @strongify(self)
            [self startRunning];
        }];
        _viewModel.totalPay = self.collectMoney;
        _viewModel.realPay = self.discountMoney;
    }
    return _viewModel;
}
- (void)backToHome {
    NSInteger count = self.navigationController.viewControllers.count;
    if (self.navigationController.viewControllers.count >= 3) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count - 3] animated:YES];
    }
}
- (void)initializeMainView {
    [self createSystemView];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    CGRect myRect =CGRectMake((SCREEN_WIDTH - 204) / 2.0,WIDTH_RACE_6S(86) + 22,204, 204);
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.view.layer addSublayer:fillLayer];
    [self.view addSubview:bgView];
    WS(ws)
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    
    UILabel *moneyLble = [LSKViewFactory initializeLableWithText:KJudgeIsNullData(self.collectMoney)?NSStringFormat(@"￥%@",self.collectMoney):nil font:25 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    self.moneyLbl = moneyLble;
    [bgView addSubview:moneyLble];
    [moneyLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(WIDTH_RACE_6S(60));
        make.height.mas_equalTo(22);
        make.centerX.equalTo(bgView);
    }];
    
    UIImageView *scanImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"shaoyishao_kuang")];
    [bgView addSubview:scanImg];
    [scanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLble.mas_bottom).with.offset(WIDTH_RACE_6S(26));
        make.centerX.equalTo(bgView);
        make.width.mas_equalTo(204);
    }];
    
    UIImageView *lineImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"shaoyishao_xian")];
    lineImage.frame = CGRectMake((SCREEN_WIDTH - 298 / 2.0) / 2.0, WIDTH_RACE_6S(86) + 22, 298 / 2.0, 0);
    self.lineView = lineImage;
    [bgView addSubview:lineImage];
    
    
    NSString *lightTitle = @"轻点照亮";
    UIButton *turnLightBtn = [LSKViewFactory initializeButtonWithTitle:lightTitle nornalImage:@"sys_deng" selectedImage:nil target:self action:@selector(turnLightAction) textfont:10 textColor:COLOR_WHITECOLOR backgroundColor:nil backgroundImage:nil];
    CGFloat width = [lightTitle calculateTextWidth:10];
    turnLightBtn.titleEdgeInsets = UIEdgeInsetsMake(34, (width - 60) / 2.0, 0, 5);
    turnLightBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 23, 0, 23);
    [bgView addSubview:turnLightBtn];
    [turnLightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanImg.mas_bottom).with.offset(WIDTH_RACE_6S(25));
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    
    UILabel *remarkLbl = [LSKViewFactory initializeLableWithText:@"将顾客付款码放入框内，即可自动扫描" font:10 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    [bgView addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(turnLightBtn.mas_bottom).with.offset(WIDTH_RACE_6S(15));
        make.centerX.equalTo(bgView);
    }];
    
    UIButton *exchangeBtn = [LSKViewFactory initializeButtonWithTitle:@"切换二维码收款" nornalImage:@"sys_qrcode" selectedImage:nil target:self action:@selector(exchangeQRcodeAction) textfont:12 textColor:COLOR_WHITECOLOR backgroundColor:nil backgroundImage:nil];
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
    [self startRunning];
}
- (void)exchangeQRcodeAction {
    PPSSShopCardVC *card = [[PPSSShopCardVC alloc]init];
    [self.navigationController pushViewController:card animated:YES];
    if (_isTurnOnLight) {
        [self turnLightAction];
    }
}
- (void)turnLightAction {
    [_device lockForConfiguration:nil];
    if (!_isTurnOnLight) {
        _isTurnOnLight = YES;
        [_device setTorchMode:AVCaptureTorchModeOn];
        [_device setFlashMode:AVCaptureFlashModeOn];
    } else {
        _isTurnOnLight = NO;
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device setFlashMode:AVCaptureFlashModeOff];
    }
    [_device unlockForConfiguration];
}
-(void)createSystemView
{
//    _isStart = YES;
    _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    // Input
    _input = [ AVCaptureDeviceInput deviceInputWithDevice : self.device error : nil ];
    // Output
    _output = [[ AVCaptureMetadataOutput alloc ] init ];
    CGFloat top = WIDTH_RACE_6S(86) + 22;
    [ _output setRectOfInterest : CGRectMake (top  / VIEW_MAIN_HEIGHT ,((SCREEN_WIDTH - 204) / 2) / SCREEN_WIDTH ,204  / VIEW_MAIN_HEIGHT,204 / SCREEN_WIDTH)];
    [ _output setMetadataObjectsDelegate : self queue : dispatch_get_main_queue ()];
    
    // Session
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[ AVCaptureSession alloc ] init ];
    [ _session setSessionPreset : AVCaptureSessionPresetHigh ];
    if ([ _session canAddInput : self . input ]) {
        [ _session addInput : self . input ];
    }
    if ([_session canAddOutput : self.output ]) {
        [_session addOutput : self.output ];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output . metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
                                      AVMetadataObjectTypeCode39Code,
                                      AVMetadataObjectTypeCode39Mod43Code,
                                      AVMetadataObjectTypeEAN13Code,
                                      AVMetadataObjectTypeEAN8Code,
                                      AVMetadataObjectTypeCode93Code,
                                      AVMetadataObjectTypeCode128Code,
                                      AVMetadataObjectTypePDF417Code,
                                      AVMetadataObjectTypeQRCode,
                                      AVMetadataObjectTypeAztecCode] ;
    // Preview
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : _session ];
    _preview . videoGravity = AVLayerVideoGravityResizeAspectFill ;
    _preview.frame = self.view.layer.bounds ;
    [self. view.layer insertSublayer : _preview atIndex : 0 ];
//    [_session startRunning ];
    
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
