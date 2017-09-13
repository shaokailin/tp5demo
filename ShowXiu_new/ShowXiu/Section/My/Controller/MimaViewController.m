//
//  MimaViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/9.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MimaViewController.h"

@interface MimaViewController ()
@property (nonatomic, strong)UITextField *MoTextField;
@property (nonatomic, strong)UITextField *yanTextField;

@end

@implementation MimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    [self addView];
}
- (void)addView{
    self.MoTextField = [[UITextField alloc]init];
    _MoTextField.frame = CGRectMake(20, 100, kScreen_w - 40, 40);
    _MoTextField.placeholder = @"请输入密码";
    //    [_MoTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //    _MoTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _MoTextField.layer.cornerRadius = 20;
    _MoTextField.layer.borderWidth = 1.0;
    _MoTextField.keyboardType = UIKeyboardTypeNumberPad;
    _MoTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _MoTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _MoTextField.leftView = imageViewPwd;
    _MoTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_MoTextField];
    
    //验证码
    self.yanTextField = [[UITextField alloc]init];
    _yanTextField.frame = CGRectMake(20, 160, kScreen_w - 40, 40);
    _yanTextField.placeholder = @"请在次输入密码";
    //    [_yanTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //    _yanTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _yanTextField.layer.cornerRadius = 20
    ;
    _yanTextField.layer.borderWidth = 1.0;
    _yanTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _yanTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwdqV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _yanTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _yanTextField.leftView = imageViewPwdqV;
    _yanTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_yanTextField];
    
    
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
    NSDictionary *dic= @{@"mob":self.shoujiString,@"uid":uidS,@"code":self.yanString,@"new_pwd":self.MoTextField.text,@"confirm_pwd":self.yanTextField.text};
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,bindingURL];
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"绑定成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];

        }];
        
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        [defatults setObject:self.shoujiString forKey:user_loginZH];
        [defatults setObject:self.MoTextField.text forKey:user_passMM];
      
        [defatults synchronize];
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
    
    
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
