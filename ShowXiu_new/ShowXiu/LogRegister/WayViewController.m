//
//  WayViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/29.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "WayViewController.h"
#import "LandingViewController.h"
#import "AccountLoginViewController.h"
@interface WayViewController ()

@end

@implementation WayViewController


//- (WayView *)wayView{
//    if (!_wayView){
//        NSArray *nibcontents = [[NSBundle mainBundle] loadNibNamed:@"WayView" owner:nil options:nil];
//        _wayView = [nibcontents lastObject];
//        _wayView.frame  = CGRectMake(0, 0, kScreen_w, kScreen_h);
//    }
//    return _wayView;
//}
//



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户登录";
    [self addView];
    
    
}
- (void)addView{
    UILabel *fangshilabel = [[UILabel alloc]init];
    fangshilabel.frame = CGRectMake(20, 80, kScreen_w - 40, 20);
    fangshilabel.text = @"请选择您的登陆方式:";
    fangshilabel.textColor = [UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:1];
    [self.view addSubview:fangshilabel];
    
    UIView *iamView = [[UIView alloc]init];
    iamView.frame = CGRectMake(kScreen_w / 2 - 60, 150, 120, 120);
    iamView.backgroundColor = [UIColor colorWithRed:215.0/255.0 green:76.0/255.0 blue:110.0/255.0 alpha:1];
    iamView.layer.cornerRadius = 60;
    iamView.layer.masksToBounds = YES;
    [self.view addSubview:iamView];
    
    UIImageView *tuView = [[UIImageView alloc]init];
    tuView.frame = CGRectMake(31, 5, 58, 110);
    tuView.image = [UIImage imageNamed:@"组-1"];
    [iamView addSubview:tuView];
    
    UILabel *tiLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, kScreen_w - 40, 20)];
    tiLabel.text = @"温馨提示：如果您还没有账号请先注册";
    tiLabel.textColor = [UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1];
    [self.view addSubview:tiLabel];
    
    UILabel *xianLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 350, kScreen_w - 40, 1)];
    xianLabel.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    xianLabel.alpha = 0.6;
    [self.view addSubview:xianLabel];
    
    UIImageView *baioVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_w/2 - 22, 339, 22, 22)];
    baioVeiw.image = [UIImage imageNamed:@"组-2"];
    baioVeiw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baioVeiw];
    
    UILabel *xuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 380, kScreen_w - 40,20)];
    xuanLabel.text = @"你还可以选择";
    
    xuanLabel.textColor = [UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1];
    xuanLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xuanLabel];
    
    UIButton *dengButton = [[UIButton alloc]init];
    dengButton.frame = CGRectMake(kScreen_w / 2 - 120, 410, 100, 40);
    dengButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [dengButton setTitle:@"账号登陆" forState:UIControlStateNormal];
    [dengButton setTitleColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    [dengButton addTarget:self action:@selector(adddengButton:) forControlEvents:UIControlEventTouchUpInside];
    dengButton.layer.cornerRadius = 20;
    dengButton.layer.masksToBounds = YES;
    dengButton.layer.borderWidth = 2;
    dengButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:dengButton];
    
    UIButton *zuceButton = [[UIButton alloc]init];
    zuceButton.frame = CGRectMake(kScreen_w / 2 + 20, 410, 100, 40);
    zuceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [zuceButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [zuceButton setTitleColor:[UIColor colorWithRed:233.0/255.0 green:99.0/255.0 blue:50.0/255.0 alpha:1] forState:UIControlStateNormal];
    [zuceButton addTarget:self action:@selector(addzuceButton:) forControlEvents:UIControlEventTouchUpInside];
    zuceButton.layer.cornerRadius = 20;
    zuceButton.layer.masksToBounds = YES;
    zuceButton.layer.borderWidth = 2;
    //    dengButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    [self.view addSubview:zuceButton];
    
    
}
//登陆
- (void)adddengButton:(UIButton *)sender{
    LandingViewController *landingView = [[LandingViewController alloc]init];
    [self.navigationController pushViewController:landingView animated:nil];
    
}
//注册
- (void)addzuceButton:(UIButton *)sender{
    AccountLoginViewController *AccountLoginView = [[AccountLoginViewController alloc]init];
    AccountLoginView.xingString = self.xingString;
    
    [self.navigationController pushViewController:AccountLoginView animated:nil];
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
