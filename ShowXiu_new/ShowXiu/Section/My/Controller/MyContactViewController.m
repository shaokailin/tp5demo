//
//  MyContactViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyContactViewController.h"
#import "ZQTColorSwitch.h"
@interface MyContactViewController ()
@property (nonatomic, strong)UITextField *motextFiled;
@property (nonatomic, strong)UITextField *WXtextFiled;
@property (nonatomic, strong)ZQTColorSwitch *nkColorSwitch1;
@property (nonatomic, copy)NSString *tySTring1;
@property (nonatomic, strong)ZQTColorSwitch *nkColorSwitch2;
@property (nonatomic, copy)NSString *tySTring2;


@end

@implementation MyContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    self.navigationItem.title = @"联系方式";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.tySTring1 = @"1";
    self.tySTring2 = @"2";
    self.navigationItem.leftBarButtonItem = leftItem;
    [self laodData];
   
    [self addView];
    

    
}
- (void)addView{
    
    UILabel *moLabel = [[UILabel alloc]init];
    moLabel.frame = CGRectMake(0, 65, 100, 50);
    moLabel.textAlignment = NSTextAlignmentCenter;
    moLabel.text = @"手机号";
    moLabel.font = [UIFont systemFontOfSize:16];
    moLabel.alpha = 0.8;
    moLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moLabel];
    
    self.motextFiled = [[UITextField alloc]init];
    _motextFiled.placeholder = @"请填写手机号码";
    _motextFiled.frame = CGRectMake(100, 65, kScreen_w - 170, 50);
    _motextFiled.font = [UIFont systemFontOfSize:16];
    _motextFiled.alpha = 0.8;
    _motextFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_motextFiled];
    
    UIView *NKView1 = [[UIView alloc]init];
    NKView1.frame = CGRectMake(kScreen_w - 70, 65, 70, 50);
    NKView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NKView1];
    self.nkColorSwitch1 = [[ZQTColorSwitch alloc] initWithFrame:CGRectMake(kScreen_w - 70, 80, 50, 25)];
    [_nkColorSwitch1 addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    _nkColorSwitch1.onBackLabel.text = @"隐藏";
    _nkColorSwitch1.offBackLabel.text = @"公开";
    _nkColorSwitch1.tag = 1001;
    _nkColorSwitch1.onBackLabel.textColor = [UIColor whiteColor];
    [_nkColorSwitch1 setTintColor:[UIColor colorWithRed:247.0/255.0 green:88.0/255.0 blue:134.0/255.0 alpha:1]];
    [_nkColorSwitch1 setOnTintColor:[UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1]];
    [_nkColorSwitch1 setThumbTintColor:[UIColor whiteColor]];
    [self.view addSubview:_nkColorSwitch1];
    
    
    UILabel *WXLabel = [[UILabel alloc]init];
    WXLabel.frame = CGRectMake(0, 116, 100, 50);
    WXLabel.textAlignment = NSTextAlignmentCenter;
    WXLabel.text = @"微信号";
    WXLabel.font = [UIFont systemFontOfSize:16];
    WXLabel.alpha = 0.8;
    WXLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WXLabel];
    
    self.WXtextFiled = [[UITextField alloc]init];
    _WXtextFiled.placeholder = @"请填写微信号码";
    _WXtextFiled.frame = CGRectMake(100, 116, kScreen_w - 170, 50);
    _WXtextFiled.font = [UIFont systemFontOfSize:16];
    _WXtextFiled.alpha = 0.8;
    _WXtextFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_WXtextFiled];
    
    UIView *NKView = [[UIView alloc]init];
    NKView.frame = CGRectMake(kScreen_w - 70, 116, 70, 50);
    NKView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NKView];
    self.nkColorSwitch2 = [[ZQTColorSwitch alloc] initWithFrame:CGRectMake(kScreen_w - 70, 131, 50, 25)];
    [_nkColorSwitch2 addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    _nkColorSwitch2.onBackLabel.text = @"隐藏";
    _nkColorSwitch2.offBackLabel.text = @"公开";
    _nkColorSwitch2.tag = 1002;
    _nkColorSwitch2.onBackLabel.textColor = [UIColor whiteColor];
    [_nkColorSwitch2 setTintColor:[UIColor colorWithRed:247.0/255.0 green:88.0/255.0 blue:134.0/255.0 alpha:1]];
    [_nkColorSwitch2 setOnTintColor:[UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1]];
    [_nkColorSwitch2 setThumbTintColor:[UIColor whiteColor]];
    [self.view addSubview:_nkColorSwitch2];

    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(24, 170, kScreen_w - 24, 21);
    title.text = @"公开后，只有VIP会员才能查看你联系方式";
    title.font = [UIFont systemFontOfSize:14];
    title.alpha = 0.4;
    [self.view addSubview:title];

    UIButton * wanButton = [[UIButton alloc]init];
    wanButton.frame = CGRectMake(24, 237, kScreen_w - 48, 40);
    [wanButton setTitle:@"完成" forState:UIControlStateNormal];
    [wanButton addTarget:self action:@selector(addwanButton:) forControlEvents:UIControlEventTouchUpInside];
    wanButton.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:88.0/255.0 blue:134.0/255.0 alpha:1];
    wanButton.layer.cornerRadius = 20;
    [self.view addSubview:wanButton];
    
}
#pragma mark --数据请求
- (void)laodData{

        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
        NSString *uidS = [defatults objectForKey:uidSG];
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_lxfsshow];
        NSDictionary *dic= @{@"uid":uidS};
        
        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
            self.WXtextFiled.text = result[@"data"][@"wechat"];
            self.motextFiled.text = result[@"data"][@"tel"];
            NSString *string = [NSString stringWithFormat:@"%@",result[@"data"][@"telstatus"]];
            if ([string isEqualToString:@"1"]) {
                _nkColorSwitch1.on = NO;
            }else {
                _nkColorSwitch1.on = YES;
            }
            
            NSString *wechatstatus = [NSString stringWithFormat:@"%@",result[@"data"][@"wechatstatus"]];
            if ([wechatstatus isEqualToString:@"1"]) {
                _nkColorSwitch2.on = NO;
            }else {
                _nkColorSwitch2.on = YES;
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
//修改
- (void)baocunData{
    [SVProgressHUD showWithStatus:@"正在保存中..."];

    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    if (self.motextFiled.text == nil) {
        self.motextFiled.text = @"";
    }
    if (self.WXtextFiled.text == nil) {
        self.WXtextFiled.text = @"";
    }
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_Mylxfs];
    NSDictionary *dic= @{@"uid":uidS,@"mob":self.motextFiled.text,@"weixin":self.WXtextFiled.text};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [self shezhiData];
      
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        
    }];

    
}
//设置
- (void)shezhiData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_Setlxfs];
    NSDictionary *dic= @{@"uid":uidS,@"data":@"mob",@"value":self.tySTring1};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
     
        [self WXData];
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];

}
- (void)WXData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_Setlxfs];
    NSDictionary *dic= @{@"uid":uidS,@"data":@"weixin",@"value":self.tySTring2};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        [SVProgressHUD dismissWithDelay:1.0];

        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        
    }];
    

}



#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark NKColorSwitch
- (void)switchPressed:(ZQTColorSwitch *)sender
{
    ZQTColorSwitch *nkswitch = (ZQTColorSwitch *)sender;
    if (nkswitch.isOn)
        if (sender.tag == 1001) {
            self.tySTring1 = @"0";
        }else {
            self.tySTring2 = @"0";
        }
    else
        if (sender.tag == 1001) {
            self.tySTring1 = @"1";
        }else {
            self.tySTring2 = @"1";
        }
        
}
//完成
- (void)addwanButton:(UIButton *)sender{
    [self baocunData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击屏幕的时候就结束编辑，方便又快捷
    [self.view endEditing:YES];//结束编辑
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
