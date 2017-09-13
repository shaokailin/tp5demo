//
//  LandingViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/29.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "LandingViewController.h"
#import "AccountLoginViewController.h"
@interface LandingViewController ()
@property (nonatomic, strong)UITextField *accountTextField;
//密码
@property (nonatomic, strong)UITextField *passwordTextField;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    self.title = @"用户登陆";
    [self addView];
    
}
- (void)addView{
    self.accountTextField = [[UITextField alloc]init];
    _accountTextField.frame = CGRectMake(0, 105, kScreen_w, 40);
    _accountTextField.placeholder = @"  手机/账号";
    _accountTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_accountTextField];
    
    self.passwordTextField = [[UITextField alloc]init];
    _passwordTextField.frame = CGRectMake(0, 146, kScreen_w, 40);
    _passwordTextField.placeholder = @"  密码";
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_passwordTextField];
    
    UIButton *LandeingButton = [[UIButton alloc]init];
    LandeingButton.frame = CGRectMake(20, 230, kScreen_w - 40, 40);
    LandeingButton.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:107.0/255.0 blue:140.0/255.0 alpha:1];
    [LandeingButton setTitle:@"登陆" forState:UIControlStateNormal];
    [LandeingButton addTarget:self action:@selector(addLandeingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LandeingButton];
    
    UIButton *zhuceButton = [[UIButton alloc]init];
    zhuceButton.frame = CGRectMake(kScreen_w/2 - 40, kScreen_h - 100, 80, 20);
    [zhuceButton setTitle:@"免费注册" forState:UIControlStateNormal];
    zhuceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [zhuceButton addTarget:self action:@selector(addzhuceButton:) forControlEvents:UIControlEventTouchUpInside];
    [zhuceButton setTitleColor:[UIColor colorWithRed:251.0/255.0 green:107.0/255.0 blue:140.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:zhuceButton];
    
}
//登陆
- (void)addLandeingButton:(UIButton *)sender{
    
}
//免费注册
- (void)addzhuceButton:(UIButton *)sender{
    AccountLoginViewController *AccountLoginView = [[AccountLoginViewController alloc]init];
    AccountLoginView.xingString = self.xingString;
    [self.navigationController pushViewController:AccountLoginView animated:nil];

//    [self.navigationController popViewControllerAnimated:YES];
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
