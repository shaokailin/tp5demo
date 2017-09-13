//
//  OrderViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/7.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "OrderViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "WXApiObject.h"
#import "WXApi.h"
@interface OrderViewController ()
@property (nonatomic, strong)NSDictionary *weiDic;
@property (nonatomic, strong)NSString *qianstring;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"支付订单";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self addView];
    
    
}
- (void)addView{
    UILabel *dingLabel = [[UILabel alloc]init];
    dingLabel.frame = CGRectMake(12, 64, kScreen_w - 24, 30);
    dingLabel.text = @"订单详情";
    dingLabel.font = [UIFont systemFontOfSize:15];
    dingLabel.alpha = 0.6;
    dingLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:dingLabel];
    
    UIView *xiangView = [[UIView alloc]init];
    xiangView.backgroundColor = [UIColor whiteColor];
    xiangView.frame = CGRectMake(0, 94, kScreen_w, 50);
    [self.view addSubview:xiangView];
    
    UILabel *neiLabel = [[UILabel alloc]init];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    CGSize size=[self.name sizeWithAttributes:attrs];
    neiLabel.frame = CGRectMake(12, 0, size.width, 50);
    neiLabel.font = [UIFont systemFontOfSize:16];
    neiLabel.text = self.name;
    neiLabel.textColor = [UIColor blackColor];
    [xiangView addSubview:neiLabel];
    
    UILabel *monyLabel = [[UILabel alloc]init];
    monyLabel.frame = CGRectMake(22+ size.width , 0, 200 , 50);
    monyLabel.font = [UIFont systemFontOfSize:16];
    monyLabel.text = self.mony;
    monyLabel.textColor = hong;
    monyLabel.textAlignment = NSTextAlignmentLeft;
    [xiangView addSubview:monyLabel];
    
    UILabel *tyLabel = [[UILabel alloc]init];
    tyLabel.frame = CGRectMake(12, 156, kScreen_w - 24, 30);
    tyLabel.text = @"支付方式";
    tyLabel.alpha = 0.6;
    tyLabel.font = [UIFont systemFontOfSize:15];
    tyLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tyLabel];
    //微信支付
    UIView *WXView = [[UIView alloc]init];
    WXView.backgroundColor = [UIColor whiteColor];
    WXView.frame = CGRectMake(0, 186, kScreen_w, 160);
    [self.view addSubview:WXView];
    
    UIButton *WXButton = [[UIButton alloc]init];
    WXButton.frame = CGRectMake(0, 0, kScreen_w, 80);
    [WXButton addTarget:self action:@selector(addWXButton:) forControlEvents:UIControlEventTouchUpInside];
    [WXView addSubview:WXButton];
    
    UIImageView * WxImaView = [[UIImageView alloc]init];
    WxImaView.frame = CGRectMake(12, 10, 60, 60);
    WxImaView.image = [UIImage imageNamed:@"icon-wechat"];
    [WXView addSubview:WxImaView];
    
    UILabel *WXLabel = [[UILabel alloc]init];
    WXLabel.frame = CGRectMake(88, 14, 200, 30);
    WXLabel.text = @"微信支付";
    [WXView addSubview:WXLabel];
    
    UILabel *WXLabel2 = [[UILabel alloc]init];
    WXLabel2.frame = CGRectMake(88, 44, 200, 20);
    WXLabel2.text = @"推荐开通微信支付的用户使用";
    WXLabel2.font = [UIFont systemFontOfSize:13];
    WXLabel2.alpha = 0.6;
    [WXView addSubview:WXLabel2];
    
    UIImageView * jianImageView = [[UIImageView alloc]init];
    jianImageView.frame = CGRectMake(kScreen_w - 30, 32, 9, 15);
    jianImageView.image = [UIImage imageNamed:@"icon-next"];
    [WXView addSubview:jianImageView];
    
    UILabel *xianLabel = [[UILabel alloc]init];
    xianLabel.frame = CGRectMake(12, 80, kScreen_w - 24, 1);
    xianLabel.backgroundColor = [UIColor blackColor];
    xianLabel.alpha = 0.3;
    [WXView addSubview:xianLabel];
    
    //支付宝支付
    UIButton *ZFBButton = [[UIButton alloc]init];
    ZFBButton.frame = CGRectMake(0, 80, kScreen_w, 80);
    [ZFBButton addTarget:self action:@selector(addZFBButton:) forControlEvents:UIControlEventTouchUpInside];
    [WXView addSubview:ZFBButton];
    

    UIImageView * ZFBImaView = [[UIImageView alloc]init];
    ZFBImaView.frame = CGRectMake(12, 90, 60, 60);
    ZFBImaView.image = [UIImage imageNamed:@"icon-alipay"];
    [WXView addSubview:ZFBImaView];
    
    UILabel *ZFBLabel = [[UILabel alloc]init];
    ZFBLabel.frame = CGRectMake(88, 94, 200, 30);
    ZFBLabel.text = @"微信支付";
    [WXView addSubview:ZFBLabel];
    
    UILabel *ZFBLabel2 = [[UILabel alloc]init];
    ZFBLabel2.frame = CGRectMake(88, 124, 200, 20);
    ZFBLabel2.text = @"推荐开通微信支付的用户使用";
    ZFBLabel2.font = [UIFont systemFontOfSize:13];
    ZFBLabel2.alpha = 0.6;
    [WXView addSubview:ZFBLabel2];
    
    UIImageView * jianImageView2 = [[UIImageView alloc]init];
    jianImageView2.frame = CGRectMake(kScreen_w - 30, 112, 9, 15);
    jianImageView2.image = [UIImage imageNamed:@"icon-next"];
    [WXView addSubview:jianImageView2];
    
    UILabel *yinanLabel = [[UILabel alloc]init];
    yinanLabel.frame = CGRectMake(12, 346, kScreen_w - 24, 30);
    yinanLabel.text = @"疑难解答";
    yinanLabel.font = [UIFont systemFontOfSize:15];
    yinanLabel.alpha = 0.6;
    yinanLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:yinanLabel];
    
    UIView *YIView = [[UIView alloc]init];
    YIView.backgroundColor = [UIColor whiteColor];
    YIView.frame = CGRectMake(0, 376, kScreen_w, 130);
    [self.view addSubview:YIView];
    
    UILabel *yiLabel = [[UILabel alloc]init];
    yiLabel.frame = CGRectMake(12, 8, kScreen_w - 24, 34);
    yiLabel.numberOfLines = 0;
    yiLabel.text = @"亲爱的用户,您在支付的过程中，有任何疑惑或者疑难，欢迎在线咨询，客服妹妹会在第一时间回复并帮助你解决问题。";
    yiLabel.font = [UIFont systemFontOfSize:12];
    yiLabel.alpha = 0.4;
    [YIView addSubview:yiLabel];

    UIButton *QQButton = [[UIButton alloc]init];
    QQButton.frame = CGRectMake(12, 50, kScreen_w - 24, 40);
    QQButton.layer.cornerRadius = 5;
    QQButton.layer.masksToBounds = YES;
    QQButton.backgroundColor = hong;
    [QQButton setTitle:@"QQ客服" forState:UIControlStateNormal];
    [QQButton addTarget:self action:@selector(addQQButton:) forControlEvents:UIControlEventTouchUpInside];
    [YIView addSubview:QQButton];
 
}
//微信支付
- (void)addWXButton:(UIButton *)sender{
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_payApi];
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
        NSString *uidS = [defatults objectForKey:uidSG];
        
        
        NSDictionary *dic = @{@"uid":uidS,@"accountType":self.ZFtype,@"accountId":self.goID,@"phoneType":@"2",@"accountForm":@"1",@"hash":@""};
        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
//            if([self.zhitype isEqualToString:@"0"]){
//                self.qianstring = result[@"data"][@"orderString"];
//                [self zhifu];
//                
//            }else {
                self.weiDic = result[@"data"];
                [self weifu];
//            }
            
            
            
        } withError:^(NSString *msg, NSError *error) {
            
        }];
        
    

}
//支付宝
- (void)addZFBButton:(UIButton *)sender{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_payApi];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    
    NSDictionary *dic = @{@"uid":uidS,@"accountType":self.ZFtype,@"accountId":self.goID,@"phoneType":@"2",@"accountForm":@"1",@"hash":@""};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.qianstring = result[@"data"][@"orderString"];
        [self zhifu];
        
        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
}


//QQ客服
- (void)addQQButton:(UIButton *)sender{
    //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
    NSString  *qqNumber= [NSString stringWithFormat:@"%@",self.qqST];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"nil" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
//            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            return ;
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 支付
- (void)zhifu{
    NSString *appScheme = @"alisdkdemoLixiuxiu";
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
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else if(resultStatu ==  8000){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"订单正在处理中" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                    [self participatePayWX];
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
        }else if(resultStatu == 4000) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"充值订单失败" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                    [self participatePayWX];
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            //[self mbhud:str numbertime:1];
        }
        
        //
    }];
}


    


- (void)weifu{
    
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
    
    
    
}



#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:nil];
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
