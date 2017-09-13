//
//  TopUpView.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "TopUpTwoView.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "JInModel.h"
#import "MyChongModel.h"
#import "MyChongTableViewCell.h"
#import <StoreKit/StoreKit.h>

#define PRODUCTID @"4930" //商品ID（请填写你商品的id）
#define PRODUCT90 @"9090" //商品ID（请填写你商品的id）

@interface TopUpTwoView ()
@property (nonatomic, strong)UIButton *weiButton;
@property (nonatomic, strong)UIButton *zhifuButton;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UILabel *dayLabel1;
@property (nonatomic, strong)UILabel *monyLabel1;
@property (nonatomic, strong)UIButton *button2;
@property (nonatomic, strong)UILabel *dayLabel2;
@property (nonatomic, strong)UILabel *monyLabel2;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *motype;
@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, strong)NSString *qianstring;
@property (nonatomic, strong)NSDictionary *weiDic;
@property (strong, nonatomic) SKPayment *payment;
@property (strong, nonatomic) SKMutablePayment *g_payment;
@end
@implementation TopUpTwoView

//chongxie初始化,添加控件
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self JBladeData];
        self.backgroundColor = [UIColor whiteColor];
        UILabel *tiLabel = [UILabel new];
        tiLabel.text = @"充值VIP拥有更多特权";
        tiLabel.frame = CGRectMake(0, 10,280, 30);
        tiLabel.textAlignment = NSTextAlignmentCenter;
        tiLabel.textColor = hong;
        tiLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:tiLabel];
        
        UILabel *xian1 = [UILabel new];
        xian1.frame = CGRectMake(10, 46, 260, 1);
        xian1.backgroundColor = [UIColor blackColor];
        xian1.alpha = 0.3;
        [self addSubview:xian1];
        
        self.button1 = [UIButton new];
        _button1.frame = CGRectMake(10, 56, 120 , 76);
        [_button1 setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(addbutton1xiu:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.dayLabel1 = [UILabel new];
        _dayLabel1.frame = CGRectMake(10, 70, 120, 20);
        _dayLabel1.textAlignment = NSTextAlignmentCenter;
        _dayLabel1.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dayLabel1];
        self.monyLabel1 = [UILabel new];
        _monyLabel1.frame = CGRectMake(10, 90, 120, 38);
        _monyLabel1.textAlignment = NSTextAlignmentCenter;
        _monyLabel1.font = [UIFont systemFontOfSize:17];
        _monyLabel1.textColor = hong;
        [self addSubview:_monyLabel1];
        self.motype = @"0";
        [self addSubview:_button1];
        
        self.button2 = [UIButton new];
        _button2.frame = CGRectMake(150, 56, 120 , 76);
        [_button2 setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(addbutton2xiu:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dayLabel2 = [UILabel new];
        _dayLabel2.frame = CGRectMake(150, 70, 120, 20);
        _dayLabel2.textAlignment = NSTextAlignmentCenter;
        _dayLabel2.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dayLabel2];
        self.monyLabel2 = [UILabel new];
        _monyLabel2.frame = CGRectMake(150, 90, 120, 38);
        _monyLabel2.textAlignment = NSTextAlignmentCenter;
        _monyLabel2.font = [UIFont systemFontOfSize:17];
        _monyLabel2.textColor = hong;
        [self addSubview:_monyLabel2];
        

        [self addSubview:_button2];
        
        UILabel *xain2 = [[UILabel alloc]init];
        xain2.frame = CGRectMake(10, 140, 260, 1);
        xain2.backgroundColor = [UIColor blackColor];
        xain2.alpha = 0.3;
        [self addSubview:xain2];

        self.weiButton = [[UIButton alloc]init];
        _weiButton.frame = CGRectMake(10, 150, 120, 45);
        [_weiButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        _weiButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_weiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_weiButton addTarget:self action:@selector(addweiButton:) forControlEvents:UIControlEventTouchUpInside];
        self.type = @"1000";
        [self addSubview:_weiButton];
        

        
        self.zhifuButton = [[UIButton alloc]init];
        _zhifuButton.frame = CGRectMake(150, 150,120 , 45);
        [_zhifuButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        _zhifuButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_zhifuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_zhifuButton addTarget:self action:@selector(addzhiButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zhifuButton];
        
        UIButton *queButton = [UIButton new];
        queButton.frame = CGRectMake(10, 230, 260, 36);
        queButton.backgroundColor = hong;
        [queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [queButton setTitle:@"确定" forState:UIControlStateNormal];
        [queButton addTarget:self action:@selector(addqueButton:) forControlEvents:UIControlEventTouchUpInside];
        queButton.layer.cornerRadius = 3;
        queButton.layer.masksToBounds = YES;
        [self addSubview:queButton];
        //添加一个交易队列观察者
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
 
    }
    return self;
}
- (void)addbutton1xiu:(UIButton *)sender{
    [_button1 setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_button2 setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    self.motype = @"0";
}
- (void)addbutton2xiu:(UIButton *)sender{
    [_button2 setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_button1 setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    self.motype = @"1";
}
- (void)addweiButton:(UIButton *)sender{
    NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"uinfo"][@"is_pay"]];
    if ([str isEqualToString:@"0"]){
        
    }else {
        [_weiButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_zhifuButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        self.type = @"1000";
    }
    
    

}
- (void)addzhiButton:(UIButton *)sender{
    [_zhifuButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_weiButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    self.type = @"1001";
}
//确定
- (void)addqueButton:(UIButton *)sender{
    [self ZFdata];
}

#pragma mark - 数据请求
- (void)JBladeData{

    
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *URL11 = @"";
    NSString *uidS = [defatults objectForKey:uidSG];
    
    URL11 = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_Vipuser];
    
    
    [HttpUtils postRequestWithURL:URL11 withParameters:@{@"uid":uidS} withResult:^(id result) {
        self.dataDic = result[@"data"];
        NSString *st1 = [NSString stringWithFormat:@"%@天",_dataDic[@"vip"][0][@"day"]];
        self.dayLabel1.text = st1;
        NSString *Mst1 = [NSString stringWithFormat:@"￥ %@元",_dataDic[@"vip"][0][@"price"]];
        self.monyLabel1.text = Mst1;
        
        NSString *st2 = [NSString stringWithFormat:@"%@天",_dataDic[@"vip"][1][@"day"]];
        self.dayLabel2.text = st2;
        NSString *Mst2 = [NSString stringWithFormat:@"￥ %@元",_dataDic[@"vip"][1][@"price"]];
        self.monyLabel2.text = Mst2;
        NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"uinfo"][@"is_pay"]];
        if ([str isEqualToString:@"0"]) {
            [_weiButton setTitle:@"苹果支付" forState:UIControlStateNormal];
            _zhifuButton.hidden = YES;
            
        }else {
            [_weiButton setTitle:@"微信" forState:UIControlStateNormal];
            _zhifuButton.hidden = NO;
            [_zhifuButton setTitle:@"支付宝" forState:UIControlStateNormal];

        }
        
  
    } withError:^(NSString *msg, NSError *error) {
        
    }];
}
- (void)ZFdata{
    NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"uinfo"][@"is_pay"]];
    if ([str isEqualToString:@"0"]){
        [self testPay];
    }else {
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_payApi];
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
        NSString *uidS = [defatults objectForKey:uidSG];
        NSString *fangshi = @"";
        if ([self.type isEqualToString:@"1000"]) {
            fangshi = @"1";
        }else {
            fangshi = @"0";
        }
        int HH = [self.motype intValue];
        NSString *accountId = [NSString stringWithFormat:@"%@",self.dataDic[@"vip"][HH][@"id"]];
        
        NSDictionary *dic = @{@"uid":uidS,@"accountType":@"1",@"accountId":accountId,@"phoneType":@"2",@"accountForm":fangshi,@"hash":@""};
        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
            if([fangshi isEqualToString:@"0"]){
                self.qianstring = result[@"data"][@"orderString"];
                [self zhifu];
                
            }else {
                self.weiDic = result[@"data"];
                [self weifu];
            }
            
            
            
        } withError:^(NSString *msg, NSError *error) {
            
        }];
        

        
    }
    
    
}


#pragma mark - 支付
- (void)zhifu{
//        [_BView removeFromSuperview];
//        [_CView removeFromSuperview];
    
    NSString *appScheme = @"alisdkdemoLixiuxiu";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(participatePayWX) name:@"participatePayWX" object:nil];

    //
    [[AlipaySDK defaultService] payOrder:self.qianstring fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        // 支付宝给我们的回调信息，标示成功还是失败，还是用户取消，网络中断等信息
        // 客户端错误码
        //            9000 成功
        //            8000 正在处理中
        //            4000 订单失败
        NSString *str = resultDic[@"memo"];
        NSString *resultStatus = resultDic[@"resultStatus"];
        int resultStatu = [resultStatus intValue];
        
        if(resultStatu == 9000){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值成功" message:@"充值成功" preferredStyle:UIAlertControllerStyleAlert];
            //2.创建action按钮
            //取消样式
            
            //            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                [self laodData];
            //                [self wechat_msgData];
            //            }];
            //            [alert addAction:seqing];
            //            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else if(resultStatu ==  8000){
            //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"订单正在处理中" preferredStyle:UIAlertControllerStyleAlert];
            //
            //            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                //                    [self participatePayWX];
            //            }];
            //            [alert addAction:seqing];
            //            [self presentViewController:alert animated:YES completion:nil];
        }else if(resultStatu == 4000) {
            //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"充值订单失败" preferredStyle:UIAlertControllerStyleAlert];
            //
            //
            //            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                //                    [self participatePayWX];
            //            }];
            //            [alert addAction:seqing];
            //            [self presentViewController:alert animated:YES completion:nil];
        }else{
            //[self mbhud:str numbertime:1];
        }
        
        //
    }];
    
    //
    
    
    
}
- (void)weifu{
//    //    [_BView removeFromSuperview];
//    //    [_CView removeFromSuperview];
//    
    NSString *appid = self.weiDic[@"appid"];
    NSString *noncestr = self.weiDic[@"noncestr"];
    NSString *packages = self.weiDic[@"package"];
    NSString *partnerid = self.weiDic[@"partnerid"];
    NSString *prepayid = self.weiDic[@"prepayid"];
    NSString *sign = self.weiDic[@"sign"];
    NSString *timestamp = self.weiDic[@"timestamp"];
    
    //注册微信支付
    [WXApi registerApp:appid];
    //    [WXApi registerApp:appid withDescription:@"demo 2.0"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(participatePayWX) name:@"participatePayWX" object:nil];
    
    //发起微信支付
    PayReq *request = [[PayReq alloc]init];
    
    
    request.partnerId = partnerid;
    
    request.prepayId = prepayid;
    
    request.package = packages;
    
    request.nonceStr = noncestr;
    
    int a = [timestamp intValue];
    
    request.timeStamp = a;
    
    request.sign= sign;
    
    [WXApi sendReq:request];
//
    
    
}
- (void)participatePayWX{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:@"1" forKey:user_rankVIP];
    [defatults synchronize];
    
}
//苹果支付
- (void)testPay {
    //判断是否可进行支付
    if ([SKPaymentQueue canMakePayments]) {
        if ([self.motype isEqualToString:@"0"]) {
            [self requestProductData:PRODUCTID];

        }else {
            [self requestProductData:PRODUCT90];

        }
        
        
    } else {
        NSLog(@"不允许程序内付费");
    }
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"1--%@", [pro description]);
        NSLog(@"2--%@", [pro localizedTitle]);
        NSLog(@"3--%@", [pro localizedDescription]);
        NSLog(@"4--%@", [pro price]);
        NSLog(@"5--%@", [pro productIdentifier]);
        
        if ([self.motype isEqualToString:@"0"]) {
            if([pro.productIdentifier isEqualToString:PRODUCTID]){
                p = pro;
            }
        }else {
            if([pro.productIdentifier isEqualToString:PRODUCT90]){
                p = pro;
            }
        }
        
       
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)requestProductData:(NSString *)type {
    //根据商品ID查找商品信息
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    //创建SKProductsRequest对象，用想要出售的商品的标识来初始化， 然后附加上对应的委托对象。
    //该请求的响应包含了可用商品的本地化信息。
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
//    //接收商品信息
//    NSArray *product = response.products;
//    if ([product count] == 0) {
//        return;
//    }
//    // SKProduct对象包含了在App Store上注册的商品的本地化信息。
//    SKProduct *storeProduct = nil;
//    for (SKProduct *pro in product) {
//        if ([pro.productIdentifier isEqualToString:PRODUCTID]) {
//            storeProduct = pro;
//        }
//    }
//    //创建一个支付对象，并放到队列中
//    self.g_payment = [SKMutablePayment paymentWithProduct:storeProduct];
//    //设置购买的数量
//    self.g_payment.quantity = 1;
//    [[SKPaymentQueue defaultQueue] addPayment:self.g_payment];
//}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求商品失败%@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"反馈信息结束调用");
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    for (SKPaymentTransaction *tran in transaction) {
        // 如果小票状态是购买完成
        if (SKPaymentTransactionStatePurchased == tran.transactionState) {
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            // 更新界面或者数据，把用户购买得商品交给用户
            //返回购买的商品信息
            [self verifyPruchase];
            //商品购买成功可调用本地接口
        } else if (SKPaymentTransactionStateRestored == tran.transactionState) {
            // 将交易从交易队列中删除
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
        } else if (SKPaymentTransactionStateFailed == tran.transactionState) {
            // 支付失败
            // 将交易从交易队列中删除
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
        }
    }
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
#pragma mark 验证购买凭据

- (void)verifyPruchase {
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    // 发送网络POST请求，对购买凭据进行验证
    //测试验证地址:https://sandbox.itunes.apple.com/verifyReceipt
    //正式验证地址:https://buy.itunes.apple.com/verifyReceipt
    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *urlRequest =
    [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    urlRequest.HTTPMethod = @"POST";
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = payloadData;
    // 提交验证请求，并获得官方的验证JSON结果 iOS9后更改了另外的一个方法
    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    // 官方验证结果为空
    if (result == nil) {
        NSLog(@"验证失败");
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    if (dict != nil) {
        // 比对字典中以下信息基本上可以保证数据安全
        // bundle_id , application_version , product_id , transaction_id
        NSLog(@"验证成功！购买的商品是：%@", @"_productName");
    }
}




@end
