//
//  RetrievePasswordViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "RetrievePasswordViewController.h"

@interface RetrievePasswordViewController ()
//手机号
@property (nonatomic, strong)UITextField *MoTextField;
//验证码
@property (nonatomic, strong)UITextField *VerificationTextField;
//密码
@property (nonatomic, strong)UITextField *PaTextField;
//验证码
@property (nonatomic, strong)UIButton *lijiButton;

@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];

    
    [self addNavigation];
    [self addView];
}
- (void)addNavigation{
    self.navigationItem.title = @"密码找回";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)addView{

    self.MoTextField = [[UITextField alloc]init];
    _MoTextField.frame = CGRectMake(20, 100, kScreen_w - 40, 50);
    _MoTextField.placeholder = @"请输入手机号";
//    [_MoTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    _MoTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _MoTextField.layer.cornerRadius = 25;
    _MoTextField.layer.borderWidth = 1.0;
    _MoTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _MoTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _MoTextField.leftView = imageViewPwd;
    _MoTextField.keyboardType = UIKeyboardTypeNumberPad;
    _MoTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_MoTextField];
    
    //验证码
    self.VerificationTextField = [[UITextField alloc]init];
    _VerificationTextField.frame = CGRectMake(20, 160, kScreen_w - 40, 50);
    _VerificationTextField.placeholder = @"请输入验证码";
//    [_VerificationTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    _VerificationTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _VerificationTextField.layer.cornerRadius = 25;
    _VerificationTextField.layer.borderWidth = 1.0;
    _VerificationTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _VerificationTextField.backgroundColor = [UIColor whiteColor];
    _VerificationTextField.keyboardType = UIKeyboardTypeNumberPad;

    UIImageView *imageViewPwdqV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    
    _VerificationTextField.leftView = imageViewPwdqV;
    _VerificationTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_VerificationTextField];
    
    //获取验证码
    self.lijiButton = [[UIButton alloc]init];
    _lijiButton.frame = CGRectMake(kScreen_w - 130, 160, 100, 50);
    [_lijiButton setTitleColor:[UIColor colorWithRed:96.0/255.0 green:176.0/255.0 blue:186.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_lijiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_lijiButton addTarget:self action:@selector(addlijibuttonA:) forControlEvents:UIControlEventTouchUpInside];
    [_lijiButton setTitleColor:[UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:_lijiButton];
    
    
    
    
    self.PaTextField = [[UITextField alloc]init];
    _PaTextField.frame = CGRectMake(20, 220, kScreen_w - 40, 50);
    _PaTextField.placeholder = @"请输入6-16位新密码";
//    [_PaTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_MoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
//    _PaTextField.textColor = [UIColor whiteColor];
    //    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _PaTextField.layer.cornerRadius = 25;
    _PaTextField.layer.borderWidth = 1.0;
    _PaTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _PaTextField.backgroundColor = [UIColor whiteColor];
    UIImageView *imageViewPwdq=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    
    _PaTextField.leftView = imageViewPwdq;
    _PaTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [self.view addSubview:_PaTextField];
    
    
    
    
    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    landingButton.frame = CGRectMake(20,300,kScreen_w - 40, 50);
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 25;
    //    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"完成" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landingButton];
    
  
    
    
}
//获取验证码
- (void)addlijibuttonA:(UIButton*)sender{
    
    
    
    //倒计时
    [self startWithTimeInterval:60];
}



//完成
- (void)addlandingButton:(UIButton *)sender{
    
    

    
    
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
