//
//  MobileViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MobileViewController.h"
#import "PerfectViewController.h"
#import <AFNetworking.h>
@interface MobileViewController ()<UITextFieldDelegate>
//手机号
@property (nonatomic, strong)UITextField *MoTextField;
//验证码
@property (nonatomic, strong)UITextField *VerificationTextField;
//密码
@property (nonatomic, strong)UITextField *PaTextField;
//验证码
@property (nonatomic, strong)UIButton *lijiButton;

@end

@implementation MobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView];
    
    
}
- (void)addView{
    UIImageView *imaView = [[UIImageView alloc]init];
    imaView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    imaView.image = [UIImage imageNamed:@"bg"];
    //    imaView.backgroundColor =[UIColor redColor];
    [self.view addSubview:imaView];
    
    UIImageView *toImageView = [[UIImageView alloc]init];
    toImageView.frame = CGRectMake(kScreen_w/2 - 32, 80, 64, 45.5);
    toImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:toImageView];
    
    UILabel *Label = [[UILabel alloc]init];
    Label.frame = CGRectMake(12, 150, kScreen_w - 24, 21);
    Label.text = @"同城秀秀";
    Label.textColor = [UIColor whiteColor];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:Label];


    
    self.MoTextField = [[UITextField alloc]init];
    _MoTextField.frame = CGRectMake(20, 210, kScreen_w - 40, 40);
    _MoTextField.placeholder = @"请输入手机号";
    [_MoTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_MoTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _MoTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _MoTextField.layer.cornerRadius = 20;
    _MoTextField.layer.borderWidth = 1.0;
    _MoTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _MoTextField.backgroundColor = [UIColor clearColor];
    UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 30)];
    _MoTextField.leftView = imageViewPwd;
    _MoTextField.keyboardType = UIKeyboardTypeNumberPad;

    _MoTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _MoTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_MoTextField];
    
    //验证码
    self.VerificationTextField = [[UITextField alloc]init];
    _VerificationTextField.frame = CGRectMake(20, 260, kScreen_w - 40, 40);
    _VerificationTextField.placeholder = @"请输入验证码";
    _VerificationTextField.delegate = self;
    [_VerificationTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_VerificationTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _VerificationTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _VerificationTextField.layer.cornerRadius = 20;
    _VerificationTextField.layer.borderWidth = 1.0;
    
    _VerificationTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _VerificationTextField.backgroundColor = [UIColor clearColor];
    _VerificationTextField.keyboardType = UIKeyboardTypeNumberPad;

    UIImageView *imageViewPwdqV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    
    _VerificationTextField.leftView = imageViewPwdqV;
    _VerificationTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _VerificationTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_VerificationTextField];
    
    //获取验证码
    self.lijiButton = [[UIButton alloc]init];
    _lijiButton.frame = CGRectMake(kScreen_w - 130, 260, 100, 40);
    [_lijiButton setTitleColor:[UIColor colorWithRed:96.0/255.0 green:176.0/255.0 blue:186.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_lijiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_lijiButton addTarget:self action:@selector(addlijibuttonA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lijiButton];
    

    
    
    self.PaTextField = [[UITextField alloc]init];
    _PaTextField.frame = CGRectMake(20, 320, kScreen_w - 40, 40);
    _PaTextField.placeholder = @"请输入密码";
    [_PaTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_PaTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _PaTextField.textColor = [UIColor whiteColor];
    
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _PaTextField.layer.cornerRadius = 20;
    _PaTextField.layer.borderWidth = 1.0;
    _PaTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _PaTextField.backgroundColor = [UIColor clearColor];
    UIImageView *imageViewPwdq=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    
    _PaTextField.leftView = imageViewPwdq;
    _PaTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _PaTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_PaTextField];
    
  

    
    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    landingButton.frame = CGRectMake(20,400,kScreen_w - 40, 40);
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 20;
    //    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    landingButton.titleLabel.font = [UIFont systemFontOfSize:14];

    [self.view addSubview:landingButton];
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(20, 465, kScreen_w - 40, 21);
    tiLabel.textAlignment = NSTextAlignmentCenter;
    tiLabel.text = @"注册即表示同意《同城秀秀用户协议》";
    tiLabel.font = [UIFont systemFontOfSize:12];
    tiLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:tiLabel];
    
    
}
//获取验证码
- (void)addlijibuttonA:(UIButton*)sender{
    if (self.MoTextField.text.length == 0) {
        // 手机号为空
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码为空" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else if (![HelperClass isPhoneNumberWith:self.MoTextField
                .text]) {
        // 手机号码不正确
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码不正确" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else  {
        //倒计时
        [self startWithTimeInterval:60];
        
        NSString *st = _MoTextField.text;
              NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:st,@"mob", nil];
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,getSmsVcodeURL];


    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
        NSLog(@"请求成功");
        
        
    } withError:^(NSString *msg, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}

 
}



//注册登陆
- (void)addlandingButton:(UIButton *)sender{
    if (self.MoTextField.text.length == 0) {
        // 手机号为空
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码为空" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else if (![HelperClass isPhoneNumberWith:self.MoTextField
                .text]) {
        // 手机号码不正确
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码不正确" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.PaTextField.text.length == 0) {
        // 密码为空
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码为空" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.PaTextField.text.length < 6){
        // 密码长度小于6位
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码长度小于6位" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else {

    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,registerURL];
    
        NSDictionary *dic= @{@"mob":_MoTextField.text,@"pass":_PaTextField.text,@"mobcode":_VerificationTextField.text};

    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSDictionary *dic = result[@"data"];
  
        NSLog(@"请求成功");
        //成功的时候
        PerfectViewController *PerfectView = [[PerfectViewController alloc]init];
        PerfectView.dic = dic;
        UINavigationController *PerfectViewNC = [[UINavigationController alloc] initWithRootViewController:PerfectView];
        [self showViewController:PerfectViewNC sender:nil];
        

        
        
    } withError:^(NSString *msg, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    }

    
    PerfectViewController *PerfectView = [[PerfectViewController alloc]init];
//    PerfectView.dic = dic;
    UINavigationController *PerfectViewNC = [[UINavigationController alloc] initWithRootViewController:PerfectView];
    [self showViewController:PerfectViewNC sender:nil];
    
    
    
    
}
//倒计时
- (void)startWithTimeInterval:(double)timeLine
{
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //                _button.backgroundColor = ;
                [_lijiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _lijiButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //                _button.backgroundColor = kRGB(254, 207, 9);
                if ([timeStr isEqualToString:@"0"]) {
                    [_lijiButton setTitle:@"60s" forState:UIControlStateNormal];
                    _lijiButton.userInteractionEnabled = NO;
                    
                }else{
                    [_lijiButton setTitle:[NSString stringWithFormat:@"%@s",timeStr] forState:UIControlStateNormal];
                    _lijiButton.userInteractionEnabled = NO;
                }
                
                
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.MoTextField) {
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"手机号不能超过11位"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];

            return NO;
        }
    }else if(textField == self.VerificationTextField){
        if (string.length == 0)
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"验证码不能超过6位"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return NO;
        }

        
    }
    
    
    
    return YES;
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
