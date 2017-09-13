//
//  GaiMiViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/9.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "GaiMiViewController.h"

@interface GaiMiViewController ()
@property (nonatomic, strong)UITextField *YuTextField;
@property (nonatomic, strong)UITextField *xinTextField;
@property (nonatomic, strong)UITextField *TwoxinTextField;

@end

@implementation GaiMiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    [self addView];


}
- (void)addView{
    self.YuTextField = [[UITextField alloc]init];
    _YuTextField.frame = CGRectMake(20, 100, kScreen_w - 40, 40);
    _YuTextField.placeholder = @"请输入密码";
    //    [_MoTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //    _MoTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _YuTextField.layer.cornerRadius = 20;
    _YuTextField.layer.borderWidth = 1.0;
    _YuTextField.keyboardType = UIKeyboardTypeNumberPad;
    _YuTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _YuTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _YuTextField.leftView = imageViewPwd;
    _YuTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_YuTextField];
    
    //验证码
    self.xinTextField = [[UITextField alloc]init];
    _xinTextField.frame = CGRectMake(20, 160, kScreen_w - 40, 40);
    _xinTextField.placeholder = @"请在次输入密码";
    //    [_yanTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //    _yanTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _xinTextField.layer.cornerRadius = 20
    ;
    _xinTextField.layer.borderWidth = 1.0;
    _xinTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _xinTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwdqV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _xinTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _xinTextField.leftView = imageViewPwdqV;
    _xinTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_xinTextField];
    
    self.TwoxinTextField = [[UITextField alloc]init];
    _TwoxinTextField.frame = CGRectMake(20, 160, kScreen_w - 40, 40);
    _TwoxinTextField.placeholder = @"请在次输入密码";
    //    [_yanTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //    _yanTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _TwoxinTextField.layer.cornerRadius = 20
    ;
    _TwoxinTextField.layer.borderWidth = 1.0;
    _TwoxinTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _TwoxinTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwdqV1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _TwoxinTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _TwoxinTextField.leftView = imageViewPwdqV1;
    _TwoxinTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_TwoxinTextField];

    
    
    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    landingButton.frame = CGRectMake(20,240,kScreen_w - 40, 40);
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 20;
    //    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"绑定" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landingButton];
    
}

//绑定手机
- (void)addlandingButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
//    NSDictionary *dic= @{@"mob":self.shoujiString,@"uid":uidS,@"code":self.yanString,@"new_pwd":self.MoTextField.text,@"confirm_pwd":self.yanTextField.text};
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,bindingURL];
    
//    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
//        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"绑定成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            
//        }];
//        
//        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//        [defatults setObject:self.shoujiString forKey:user_loginZH];
//        [defatults setObject:self.MoTextField.text forKey:user_passMM];
//        
//        [defatults synchronize];
//        
//        [alert addAction:otherAction];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//        
//    } withError:^(NSString *msg, NSError *error) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            NSLog(@"确定执行");
//            
//        }];
//        
//        
//        [alert addAction:otherAction];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    }];
    
    
    
    
}



#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
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
