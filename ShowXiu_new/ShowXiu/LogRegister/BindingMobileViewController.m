//
//  BindingMobileViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "BindingMobileViewController.h"

@interface BindingMobileViewController ()
@property (nonatomic, strong)UITextField *MoTextField;
@property (nonatomic, strong)UITextField *yanTextField;
//获取验证码
@property (nonatomic, strong)UIButton *lijiButton;

@end

@implementation BindingMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    [self addNavigation];
    [self addView];
}
- (void)addNavigation{
    self.navigationItem.title = @"绑定手机号";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)addView{
    self.MoTextField = [[UITextField alloc]init];
    _MoTextField.frame = CGRectMake(20, 100, kScreen_w - 40, 40);
    _MoTextField.placeholder = @"请输入您的手机号";
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
    _yanTextField.placeholder = @"请输入验证码";
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
    
    //获取验证码
    self.lijiButton = [[UIButton alloc]init];
    _lijiButton.frame = CGRectMake(kScreen_w - 130, 160, 100, 40);
    [_lijiButton setTitleColor:[UIColor colorWithRed:96.0/255.0 green:176.0/255.0 blue:186.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_lijiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_lijiButton setTitleColor:[UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1] forState:UIControlStateNormal];
    _lijiButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_lijiButton addTarget:self action:@selector(addlijibuttonA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lijiButton];
    
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
//获取验证码
- (void)addlijibuttonA:(UIButton *)sender{
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
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,getSmsVcodeURL];
        NSString *st = _MoTextField.text;
        NSDictionary *dic= @{@"mob":st};

        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
         

            NSLog(@"请求成功");
            
            
        } withError:^(NSString *msg, NSError *error) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];

            
        }];
        
        
        
    }
    
    
    

    
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

//绑定手机
- (void)addlandingButton:(UIButton *)sender{
    
    NSDictionary *dic= @{@"mob":self.MoTextField.text,@"uid":_dataDic[@"id"],@"code":_yanTextField.text};
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,bindingURL];

    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
        NSLog(@"%@",result);
        //微信成功的时候
        BindingMobileViewController *bindView = [[BindingMobileViewController alloc]init];
        UINavigationController *bindViewNC = [[UINavigationController alloc]initWithRootViewController:bindView];
        [self showViewController:bindViewNC sender:nil];
        
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoAction" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
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
