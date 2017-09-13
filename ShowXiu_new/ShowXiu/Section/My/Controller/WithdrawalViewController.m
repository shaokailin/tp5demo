//
//  WithdrawalViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()
@property (nonatomic, strong)NSDictionary *dataDIc;
@property (nonatomic, strong)UIButton *zhifubao;
@property (nonatomic, strong)UIView *huafeiView;

@property (nonatomic, strong)UITextField *zhangTextField;
@property (nonatomic, strong)UITextField *nameTextFileld;
@property (nonatomic, strong)UITextField *jinTextFileld;

@property (nonatomic, strong)UIView *huaVeiw;
@property (nonatomic, strong)UIButton *huafei;
@property (nonatomic, strong)UITextField *shouTextFileld;
@property (nonatomic, strong)UIButton *thirtyButton;
@property (nonatomic, strong)UIButton *fiftyButton;
@property (nonatomic, strong)UIButton *onehundredButton;
@property (nonatomic, strong)UIButton *twohundredButton;
@property (nonatomic, strong)UIButton *threehundredButton;
@property (nonatomic, strong)UIButton *fivehundredButton;
@property (nonatomic, strong)UILabel *xianLabel;
@property (nonatomic, copy)NSString *monyHua;
@property (nonatomic, strong)UILabel *zhnaghu;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.title = @"提现";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [self loadData];
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:nil];
}
#pragma mark - 数据请求
- (void)loadData{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_userTx];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSDictionary *dic= @{@"uid":uidS};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.dataDIc = result[@"data"];
        if (self.zhnaghu) {
            NSString *zhnaghuString = [NSString stringWithFormat:@"账户总余额: %@",self.dataDIc[@"money"]];
            self.zhnaghu.text = zhnaghuString;

        }else {
            [self zhanghhuView];
            int a = [self.dataDIc[@"money"] intValue];
            int b = [self.dataDIc[@"moneyBL"] intValue];
            int c = a / b;
            if (c > 20) {
                self.jinTextFileld.text = [NSString stringWithFormat:@"%d",c];
            }else {
                self.jinTextFileld.text = @"0";
            }

        }
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    

}

- (void)zhanghhuView{
    UIView *yueView = [[UIView alloc]init];
    yueView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:82.0/255.0 blue:129.0/255.0 alpha:1];
    yueView.frame = CGRectMake(0, 64, kScreen_w, 90);
    [self.view addSubview:yueView];
    
    UIImageView *imaView = [[UIImageView alloc]init];
    imaView.frame = CGRectMake(12, 20, 50, 50);
    imaView.image = [UIImage imageNamed:@"WechatIMG7"];
    [yueView addSubview:imaView];
    
    NSString *zhnaghuString = [NSString stringWithFormat:@"账户总余额: %@",self.dataDIc[@"money"]];
    self.zhnaghu = [[UILabel alloc]init];
    _zhnaghu.text = zhnaghuString;
    _zhnaghu.frame = CGRectMake(72, 20, kScreen_w - 80, 20);
    _zhnaghu.font = [UIFont systemFontOfSize:15];
    _zhnaghu.alpha = 0.8;
    _zhnaghu.textColor = [UIColor whiteColor];
    [yueView addSubview:_zhnaghu];
    
    NSString *tixianString = [NSString stringWithFormat:@"最低提现金额: %@(1元=%@秀币)",self.dataDIc[@"minTx"],self.dataDIc[@"moneyBL"]];

    UILabel *tixian = [[UILabel alloc]init];
    tixian.text = tixianString;
    tixian.frame = CGRectMake(72, 50, kScreen_w - 80, 20);
    tixian.font = [UIFont systemFontOfSize:15];
    tixian.alpha = 0.8;
    tixian.textColor = [UIColor whiteColor];
    [yueView addSubview:tixian];
    
    self.zhifubao = [[UIButton alloc]init];
    self.zhifubao.frame = CGRectMake(0, 155, kScreen_w / 2, 40);
    [_zhifubao setTitle:@"支付宝" forState:UIControlStateNormal];
    _zhifubao.backgroundColor = [UIColor whiteColor];
    _zhifubao.alpha = 0.8;
    _zhifubao.titleLabel.font = [UIFont systemFontOfSize:15];
    [_zhifubao setTitleColor:[UIColor colorWithRed:248.0/255.0 green:82.0/255.0 blue:129.0/255.0 alpha:1] forState:UIControlStateNormal];
    _zhifubao.tag = 1000;
    [_zhifubao addTarget:self action:@selector(addzhifubao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zhifubao];
    
    self.huafei = [[UIButton alloc]init];
    self.huafei.frame = CGRectMake(kScreen_w / 2, 155, kScreen_w / 2, 40);
    [_huafei setTitle:@"话费充值" forState:UIControlStateNormal];
    _huafei.backgroundColor = [UIColor whiteColor];
    [_huafei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _huafei.tag = 1001;
    [_huafei addTarget:self action:@selector(addzhifubao:) forControlEvents:UIControlEventTouchUpInside];
    _huafei.alpha = 0.8;
    _huafei.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_huafei];
    
    self.xianLabel = [[UILabel alloc]init];
    _xianLabel.frame = CGRectMake(20, 200, (kScreen_w - 80) / 2, 1);
    _xianLabel.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:82.0/255.0 blue:129.0/255.0 alpha:1];
    [self.view addSubview:_xianLabel];
    

    [self typeView];
    [self addhuaView];
}
- (void)typeView{
    self.huafeiView = [[UIView alloc]init];
//    _huafeiView.backgroundColor = [[UIColor whiteColor]init];
    _huafeiView.frame = CGRectMake(0, 202, kScreen_w, kScreen_h);
    [self.view addSubview:_huafeiView];
    UILabel *hao = [[UILabel alloc]init];
    hao.frame = CGRectMake(0, 0, 100, 40);
    hao.text = @"账 号";
    hao.textAlignment = NSTextAlignmentCenter;
    hao.font = [UIFont systemFontOfSize:15];
    hao.backgroundColor  =[UIColor whiteColor];
    [_huafeiView addSubview:hao];
    
    self.zhangTextField = [[UITextField alloc]init];
    _zhangTextField.frame = CGRectMake(100, 0, kScreen_w - 100, 40);
    _zhangTextField.placeholder = @"请输入支付宝账号";
    _zhangTextField.backgroundColor = [UIColor whiteColor];
    _zhangTextField.font = [UIFont systemFontOfSize:15];
    [_huafeiView addSubview:_zhangTextField];
    
    UILabel *xing = [[UILabel alloc]init];
    xing.frame = CGRectMake(0, 41, 100, 40);
    xing.text = @"姓 名";
    xing.textAlignment = NSTextAlignmentCenter;
    xing.font = [UIFont systemFontOfSize:15];
    xing.backgroundColor  =[UIColor whiteColor];
    [_huafeiView addSubview:xing];
    
    self.nameTextFileld = [[UITextField alloc]init];
    _nameTextFileld.frame = CGRectMake(100, 41, kScreen_w - 100, 40);
    _nameTextFileld.placeholder = @"请输入支付宝昵称";
    _nameTextFileld.backgroundColor = [UIColor whiteColor];
    _nameTextFileld.font = [UIFont systemFontOfSize:15];
    [_huafeiView addSubview:_nameTextFileld];
    
    UILabel *mony = [[UILabel alloc]init];
    mony.frame = CGRectMake(0, 82, 100, 40);
    mony.text = @"金 额";
    mony.textAlignment = NSTextAlignmentCenter;
    mony.font = [UIFont systemFontOfSize:15];
    mony.backgroundColor  =[UIColor whiteColor];
    [_huafeiView addSubview:mony];
    
    self.jinTextFileld = [[UITextField alloc]init];
    _jinTextFileld.frame = CGRectMake(100, 82, kScreen_w - 100, 40);
    _jinTextFileld.placeholder = @"可提现金额";
    _jinTextFileld.backgroundColor = [UIColor whiteColor];
    _jinTextFileld.font = [UIFont systemFontOfSize:15];
    [_huafeiView addSubview:_jinTextFileld];
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(12, 122, kScreen_w - 24, 20);
    tiLabel.text = @"请正确填写支付宝账号，避免提现出现问题";
    tiLabel.font = [UIFont systemFontOfSize:14];
    tiLabel.alpha = 0.7;
    [_huafeiView addSubview:tiLabel];
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame = CGRectMake(20, 155, kScreen_w - 40, 40);
    queButton.layer.cornerRadius = 20;
    queButton.layer.masksToBounds = YES;
    [queButton setTitle:@"申请提现" forState:UIControlStateNormal];
    queButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queButton.backgroundColor = hong;
    [queButton addTarget:self action:@selector(addquanButtonOne:) forControlEvents:UIControlEventTouchUpInside];
    [_huafeiView addSubview:queButton];
    

}
- (void)addhuaView{
    self.huaVeiw = [[UIView alloc]init];
    //    _huafeiView.backgroundColor = [[UIColor whiteColor]init];
    _huaVeiw.frame = CGRectMake(0, 202, kScreen_w, kScreen_h);
    [self.view addSubview:_huaVeiw];
    UILabel *hao = [[UILabel alloc]init];
    hao.frame = CGRectMake(0, 0, 100, 40);
    hao.text = @"账 号";
    hao.textAlignment = NSTextAlignmentCenter;
    hao.font = [UIFont systemFontOfSize:15];
    hao.backgroundColor  =[UIColor whiteColor];
    [_huaVeiw addSubview:hao];
    
    self.shouTextFileld = [[UITextField alloc]init];
    _shouTextFileld.frame = CGRectMake(100, 0, kScreen_w - 100, 40);
    _shouTextFileld.placeholder = @"请输入需要充值的手机号码";
    _shouTextFileld.backgroundColor = [UIColor whiteColor];
    _shouTextFileld.font = [UIFont systemFontOfSize:15];
    [_huaVeiw addSubview:_shouTextFileld];
    
    UILabel *wen = [[UILabel alloc]init];
    wen.frame = CGRectMake(12, 45,kScreen_w - 24 , 20);
    wen.text = @"  充话费";
    wen.textAlignment = NSTextAlignmentLeft;
    wen.font = [UIFont systemFontOfSize:15];
//    wen.backgroundColor  =[UIColor whiteColor];
    [_huaVeiw addSubview:wen];
    
    self.thirtyButton = [[UIButton alloc]init];
    _thirtyButton.frame = CGRectMake(15, 71, (kScreen_w - 60) / 3, 30);
    [_thirtyButton setTitle:@"30元" forState:UIControlStateNormal];
    [_thirtyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _thirtyButton.layer.masksToBounds = YES;
    _thirtyButton.layer.cornerRadius = 15.0;
    _thirtyButton.layer.borderWidth = 1.0;
    _thirtyButton.layer.borderColor = [UIColor grayColor].CGColor;
    _thirtyButton.tag = 30;
    [_thirtyButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_thirtyButton];
    
    self.fiftyButton = [[UIButton alloc]init];
    _fiftyButton.frame = CGRectMake(30 + (kScreen_w - 60) / 3, 71, (kScreen_w - 60) / 3, 30);
    [_fiftyButton setTitle:@"50元" forState:UIControlStateNormal];
    [_fiftyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _fiftyButton.layer.masksToBounds = YES;
    _fiftyButton.layer.cornerRadius = 15.0;
    _fiftyButton.layer.borderWidth = 1.0;
    _fiftyButton.layer.borderColor = [UIColor grayColor].CGColor;
    _fiftyButton.tag = 50;
    [_fiftyButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_fiftyButton];
    
    self.onehundredButton = [[UIButton alloc]init];
    _onehundredButton.frame = CGRectMake(45 + (kScreen_w - 60) / 3 * 2, 71, (kScreen_w - 60) / 3, 30);
    [_onehundredButton setTitle:@"100元" forState:UIControlStateNormal];
    [_onehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _onehundredButton.layer.masksToBounds = YES;
    _onehundredButton.layer.cornerRadius = 15.0;
    _onehundredButton.layer.borderWidth = 1.0;
    _onehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    _onehundredButton.tag = 100;
    [_onehundredButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_onehundredButton];
    
    self.twohundredButton = [[UIButton alloc]init];
    _twohundredButton.frame = CGRectMake(15, 111, (kScreen_w - 60) / 3, 30);
    [_twohundredButton setTitle:@"200元" forState:UIControlStateNormal];
    [_twohundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _twohundredButton.layer.masksToBounds = YES;
    _twohundredButton.layer.cornerRadius = 15.0;
    _twohundredButton.layer.borderWidth = 1.0;
    _twohundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    _twohundredButton.tag = 200;
    [_twohundredButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_twohundredButton];
    
    self.threehundredButton = [[UIButton alloc]init];
    _threehundredButton.frame = CGRectMake(30 + (kScreen_w - 60) / 3, 111, (kScreen_w - 60) / 3, 30);
    [_threehundredButton setTitle:@"300元" forState:UIControlStateNormal];
    [_threehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _threehundredButton.layer.masksToBounds = YES;
    _threehundredButton.layer.cornerRadius = 15.0;
    _threehundredButton.layer.borderWidth = 1.0;
    _threehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    _threehundredButton.tag = 300;
    [_threehundredButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_threehundredButton];
    
    self.fivehundredButton = [[UIButton alloc]init];
    _fivehundredButton.frame = CGRectMake(45 + (kScreen_w - 60) / 3 * 2, 111, (kScreen_w - 60) / 3, 30);
    [_fivehundredButton setTitle:@"500元" forState:UIControlStateNormal];
    [_fivehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _fivehundredButton.layer.masksToBounds = YES;
    _fivehundredButton.layer.cornerRadius = 15.0;
    _fivehundredButton.layer.borderWidth = 1.0;
    _fivehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    _fivehundredButton.tag = 500;
    [_fivehundredButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:_fivehundredButton];
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(12, 151, kScreen_w - 24, 20);
    tiLabel.text = @"请正确填写手机号码，避免充值出现问题";
    tiLabel.font = [UIFont systemFontOfSize:14];
    tiLabel.alpha = 0.7;
    [_huaVeiw addSubview:tiLabel];
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame = CGRectMake(20, 180, kScreen_w - 40, 40);
    queButton.layer.cornerRadius = 20;
    queButton.layer.masksToBounds = YES;
    [queButton setTitle:@"充值话费" forState:UIControlStateNormal];
    [queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queButton.backgroundColor = hong;
    [queButton addTarget:self action:@selector(addquanButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    [_huaVeiw addSubview:queButton];
    
    _huaVeiw.hidden = YES;
}
//支付宝
- (void)addquanButtonOne:(UIButton *)sender{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_tixian];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSDictionary *dic= @{@"uid":uidS,@"type":@"2",@"money":self.jinTextFileld.text,@"zfb_account":self.zhangTextField.text,@"zfb_lxr":self.nameTextFileld.text};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现成功，正在等待审核" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];       [self loadData];
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    

}

//话费
- (void)addquanButtonTwo:(UIButton *)sender{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_tixianHUafei];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSDictionary *dic= @{@"uid":uidS,@"type":@"3",@"money":self.monyHua,@"mob":self.shouTextFileld.text};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            

        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];       [self loadData];
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];

    
}


#pragma mark - addzhifubao
-(void)addzhifubao:(UIButton *)sender{
    [_zhifubao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_huafei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithRed:248.0/255.0 green:82.0/255.0 blue:129.0/255.0 alpha:1] forState:UIControlStateNormal];
    if (sender.tag == 1000) {
        _xianLabel.frame = CGRectMake(20, 200, (kScreen_w - 80) / 2, 1);
        _huafeiView.hidden = NO;
        _huaVeiw.hidden = YES;
    }else {
        _xianLabel.frame = CGRectMake(60 + (kScreen_w - 80) / 2, 200, (kScreen_w - 80) / 2, 1);
        _huafeiView.hidden = YES;
        _huaVeiw.hidden = NO;
    }
}
#pragma mark - addyonghu:
- (void)addyonghu:(UIButton *)sender{
    [_thirtyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _thirtyButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_fiftyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _fiftyButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_onehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _onehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_twohundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _twohundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_threehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _threehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_fivehundredButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _fivehundredButton.layer.borderColor = [UIColor grayColor].CGColor;
//
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    self.monyHua = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
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
