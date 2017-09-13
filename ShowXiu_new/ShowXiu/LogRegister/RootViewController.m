//
//  RootViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/2/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "RootViewController.h"
#import "MobileViewController.h"
#import "BindingMobileViewController.h"
#import "RetrievePasswordViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <objc/runtime.h>
#import "ZhuCeViewController.h"
#import <YYLabel.h>
#import "NSAttributedString+YYText.h"
#import "TheUserViewController.h"
//需要引入的头文件和库
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
@interface RootViewController ()<UITextFieldDelegate>
//手机号
@property (nonatomic, strong)UITextField *MoTextField;
//密码
@property (nonatomic, strong)UITextField *PaTextField;

@property (nonatomic, assign)int a;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBarController.tabBar.hidden = YES;
//    UIImage *leimage = [UIImage imageNamed:@"形状16"];
//    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
    
    [self addView];
    
    
    
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    //    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)addView{
    UIImageView *imaView = [[UIImageView alloc]init];
    imaView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    imaView.image = [UIImage imageNamed:@"750X1334"];
//    imaView.backgroundColor =[UIColor redColor];
    [self.view addSubview:imaView];
    
    UIImageView *toImageView = [[UIImageView alloc]init];
    toImageView.frame = CGRectMake(kScreen_w/2 - 32, 90, 64, 45.5);
    toImageView.image = [UIImage imageNamed:@"组合好的拷贝3"];
    [self.view addSubview:toImageView];
    
    UILabel *Label = [[UILabel alloc]init];
    Label.frame = CGRectMake(12, 150, kScreen_w - 24, 21);
    Label.text = @"同城秀秀";
    Label.textColor = [UIColor whiteColor];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.font = [UIFont systemFontOfSize:23];
    [self.view addSubview:Label];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_loginZHST = [defatults objectForKey:user_loginZH];
    NSString *user_passMMST = [defatults objectForKey:user_passMM];
    
    self.a = 0;
    
    self.MoTextField = [[UITextField alloc]init];
    _MoTextField.frame = CGRectMake(32, 217, kScreen_w - 64, 40);
    _MoTextField.placeholder = @"请输入账号或手机号";
    _MoTextField.alpha = 0.6;
    [_MoTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_MoTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _MoTextField.textColor = [UIColor whiteColor];
//    _MoTextField.borderStyle = UITextBorderStyleRoundedRect;
    _MoTextField.layer.cornerRadius = 20;
    _MoTextField.layer.borderWidth = 1.0;
    _MoTextField.delegate = self;
    _MoTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _MoTextField.backgroundColor = [UIColor clearColor];
    UIImageView *imageViewPwd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];
    _MoTextField.leftView = imageViewPwd;
    _MoTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _MoTextField.font = [UIFont systemFontOfSize:15];
    if (user_loginZHST == nil || [user_loginZHST isEqualToString:@""]) {
        
    }else {
        _MoTextField.text = user_loginZHST;
    }
    
    
//    _MoTextField.keyboardType = UIKeyboardTypeNumberPad;

    [self.view addSubview:_MoTextField];
    
    self.PaTextField = [[UITextField alloc]init];
    _PaTextField.frame = CGRectMake(32, 272, kScreen_w - 64, 40);
    _PaTextField.placeholder = @"请输入密码";
    [self.PaTextField becomeFirstResponder];
    _PaTextField.alpha = 0.6;
    [_PaTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_PaTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _PaTextField.textColor = [UIColor whiteColor];
    _PaTextField.secureTextEntry = YES;
    _PaTextField.layer.cornerRadius = 20;
    _PaTextField.layer.borderWidth = 1.0;
    _PaTextField.delegate = self;
    _PaTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _PaTextField.backgroundColor = [UIColor clearColor];
    UIImageView *imageViewPwdq=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 40)];

    _PaTextField.leftView = imageViewPwdq;
    _PaTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _PaTextField.font = [UIFont systemFontOfSize:15];
    if (user_passMMST == nil || [user_passMMST isEqualToString:@""]) {
        
    }else{
        _PaTextField.text = @"";
        _PaTextField.text = user_passMMST;
    }
    
    [self.view addSubview:_PaTextField];
    
    //立即注册
    UIButton *lijiButton = [[UIButton alloc]init];
    lijiButton.frame = CGRectMake(32, 325, 80, 21);
    [lijiButton setTitleColor:[UIColor colorWithRed:96.0/255.0 green:176.0/255.0 blue:186.0/255.0 alpha:1] forState:UIControlStateNormal];
    [lijiButton setTitle:@"立即注册" forState:UIControlStateNormal];
    lijiButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [lijiButton addTarget:self action:@selector(addlijibutton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lijiButton];
    
    //忘记密码
    UIButton *mimaButton = [[UIButton alloc]init];
    mimaButton.frame = CGRectMake(kScreen_w - 100, 325, 80, 21);
    [mimaButton setTitleColor:[UIColor colorWithRed:96.0/255.0 green:176.0/255.0 blue:186.0/255.0 alpha:1] forState:UIControlStateNormal];
    [mimaButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    mimaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [mimaButton addTarget:self action:@selector(addmimaButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mimaButton];
    
    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    landingButton.frame = CGRectMake(32,366,kScreen_w - 64, 40);
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 20;
//    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"立即登陆" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    landingButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:landingButton];
    
    
    YYLabel *label = [YYLabel new];
    label.frame = CGRectMake(32, 414, kScreen_w - 64, 21);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.alpha = 0.6;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];

    NSString *string = [NSString stringWithFormat:@"登陆即表示同意《同城秀秀用户协议》"];
    //属性字符串 简单实用
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = [UIFont boldSystemFontOfSize:14.0f];
    text.color = [UIColor whiteColor];
//    [text setColor:[UIColor redColor] range:NSMakeRange(7, 10)];
    [text setTextHighlightRange:NSMakeRange(7, 10) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        TheUserViewController *MainView = [[TheUserViewController alloc]init];
        UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
        
        [self showViewController:tgirNVC sender:nil];
    }];
    
    label.attributedText = text;
    
   

    [self jianceWXView];
    
    
    
}
//检测是否安装微信
- (void)jianceWXView{
    //判断安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]){
        //安装了微信的处理
        UILabel *laLabel = [[UILabel alloc]init];
        laLabel.frame = CGRectMake(32, 477, kScreen_w - 64, 21);
        laLabel.text= @"———— 其他方式登陆 ————";
        laLabel.textColor = [UIColor whiteColor];
        laLabel.textAlignment = NSTextAlignmentCenter;
        laLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:laLabel];
        
        UIButton *ima = [[UIButton alloc]init];
        ima.frame = CGRectMake(kScreen_w / 2 - 22, 511, 44, 44);
        [ima setBackgroundImage:[UIImage imageNamed:@"形状-2"] forState:UIControlStateNormal];
        [ima addTarget:self action:@selector(addimaButton:) forControlEvents:UIControlEventTouchUpInside];
        ima.layer.cornerRadius = 22;
        //    ima.layer.borderWidth = 1.0;
        ima.layer.masksToBounds = YES;
        [self.view addSubview:ima];
        
        UIButton *imaLabel = [[UIButton alloc]init];
        imaLabel.frame = CGRectMake(32, 564, kScreen_w - 64, 21);
        [imaLabel setTitle:@"微信" forState:UIControlStateNormal];
        [imaLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [imaLabel addTarget:self action:@selector(addimaButton:) forControlEvents:UIControlEventTouchUpInside];
        imaLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        imaLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:imaLabel];

    } else {
        //没有安装微信的处理
        NSLog(@"没有安装微信的处理");
    }
}


//立即注册
- (void)addlijibutton:(UIButton*)sender{
//    MobileViewController *MobileView = [[MobileViewController alloc]init];
//    [self showViewController:MobileView sender:nil];
    
//    [self.navigationController pushViewController:MobileView animated:YES];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
    ZhuCeViewController *zhuceView = [[ZhuCeViewController alloc]init];
    [self.navigationController pushViewController:zhuceView animated:YES];
    
}
//忘记密码
- (void)addmimaButton:(UIButton *)sender{
    RetrievePasswordViewController *RetrieView = [[RetrievePasswordViewController alloc]init];
    UINavigationController *RetrieViewNC =[[UINavigationController alloc]initWithRootViewController:RetrieView];
    [self showViewController:RetrieViewNC sender:nil];
    
}
//立即登陆
- (void)addlandingButton:(UIButton *)sender{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,loginURL];
    NSDictionary *dic= @{@"mob":self.MoTextField.text,@"pass":_PaTextField.text};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSDictionary *dic = result[@"data"];
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        [defatults setObject:dic[@"age"] forKey:ageNL];
        [defatults setObject:dic[@"avatar"] forKey:avatarIMG];
        [defatults setObject:dic[@"id"] forKey:uidSG];
        [defatults setObject:dic[@"sex"] forKey:sexXB];
        [defatults setObject:dic[@"user_login"] forKey:user_loginZH];
        [defatults setObject:dic[@"user_pass"] forKey:user_passMM];
        [defatults setObject:dic[@"user_rank"] forKey:user_rankVIP];
        [defatults synchronize];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoAction" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoActionLL" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"firstFicationAction" object:nil];
        NSString *biaoshi = [defatults objectForKey:user_bioashi];
        if ([biaoshi isEqualToString:@"LLLLL"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            NSNumber *index = 0;
            [tabbarVc setSelectedIndex:[index intValue]];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
                
                
            } ];
        }
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    

    
    
    
}
//微信
- (void)addimaButton:(UIButton *)sender{
    
    //微信登陆
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            NSDictionary *userDict = [self getObjectData:user];
            NSLog(@"%@",userDict);
            NSString *unionid = userDict[@"rawData"][@"unionid"];
            NSString *openid = userDict[@"rawData"][@"openid"];
            NSString *headimgurl = userDict[@"rawData"][@"headimgurl"];
            NSString *nickname = userDict[@"rawData"][@"nickname"];
            NSString *sex = userDict[@"rawData"][@"sex"];
            NSString *country = userDict[@"rawData"][@"country"];
            NSString *province = userDict[@"rawData"][@"province"];
            NSString *city = userDict[@"rawData"][@"city"];
            
            NSDictionary *dic= @{@"uninonid":unionid,@"openid":openid,@"headimgurl":headimgurl,@"nickname":nickname,@"sex":sex,@"country":country,@"province":province,@"city":city};
            NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,doappwxloginURL];

            [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
                NSDictionary *dic = result[@"data"];
                NSString *st = dic[@"msg"];
                if ([dic[@"user_login"] isEqualToString:@""]) {
                    //微信成功的时候
                    BindingMobileViewController *bindView = [[BindingMobileViewController alloc]init];
                    bindView.dataDic = dic;
                    UINavigationController *bindViewNC = [[UINavigationController alloc]initWithRootViewController:bindView];
                    [self showViewController:bindViewNC sender:nil];
                    
                }else {
                    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
                    [defatults setObject:dic[@"age"] forKey:ageNL];
                    [defatults setObject:dic[@"avatar"] forKey:avatarIMG];
                    [defatults setObject:dic[@"id"] forKey:uidSG];
                    [defatults setObject:dic[@"sex"] forKey:sexXB];
                    [defatults setObject:dic[@"user_login"] forKey:user_loginZH];
                    [defatults setObject:dic[@"user_pass"] forKey:user_passMM];
                    [defatults setObject:dic[@"user_rank"] forKey:user_rankVIP];
                    [defatults synchronize];
                    
                    //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoAction" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoActionLL" object:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"firstFicationAction" object:nil];
                    NSString *biaoshi = [defatults objectForKey:user_bioashi];
                    if ([biaoshi isEqualToString:@"LLLLL"]) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else {
                        UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                        NSNumber *index = 0;
                        [tabbarVc setSelectedIndex:[index intValue]];
                        [self.navigationController dismissViewControllerAnimated:YES completion:^{
                            
                            
                            
                        } ];
                    }
                    
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];
                    
                    
                }

            } withError:^(NSString *msg, NSError *error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSLog(@"确定执行");
                    
                }];
                
                
                [alert addAction:otherAction];
                
                [self presentViewController:alert animated:YES completion:nil];
            }];
            
            
            
        }else
        {
            NSLog(@"%@",error);
        }
    }];


//    
    
    
}


- (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}
- (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.MoTextField) {
        if (string.length == 0)
            return YES;
        
//        NSInteger existedLength = textField.text.length;
//        NSInteger selectedLength = range.length;
//        NSInteger replaceLength = string.length;
//        if (existedLength - selectedLength + replaceLength > ) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"手机号不能超过11位"preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
//            [alertController addAction:cancelAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//            
//            return NO;
//        }
    }else if(textField == self.PaTextField){
//        if (string.length == 0)
//            return YES;
//        
//        NSInteger existedLength = textField.text.length;
//        NSInteger selectedLength = range.length;
//        NSInteger replaceLength = string.length;
//        if (existedLength - selectedLength + replaceLength > 6) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"验证码不能超过6位"preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
//            [alertController addAction:cancelAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//            
//            return NO;
//        }
        
        
    }
    
    
    
    return YES;
}
//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
