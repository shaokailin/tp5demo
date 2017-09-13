//
//  AccountLoginViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/30.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "PerfectViewController.h"
@interface AccountLoginViewController ()
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UIButton *ageButton;

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写用户信息";
    [self addView];
    
    
}
- (void)addView{
    self.nameTextField = [[UITextField alloc]init];
    _nameTextField.frame = CGRectMake(20, 100, kScreen_w - 40, 40);
    _nameTextField.borderStyle = UITextBorderStyleNone;
    _nameTextField.placeholder = @"请输入您的昵称";
    
    [self.view addSubview:_nameTextField];
    
    self.ageButton = [[UIButton alloc]init];
    _ageButton.frame = CGRectMake(20, 150, 100, 40);
    [_ageButton setTitle:@"29岁" forState:UIControlStateNormal];
    _ageButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_ageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ageButton addTarget:self action:@selector(addageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ageButton];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 139, kScreen_w - 40, 1);
//    label.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    label.backgroundColor = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1];
    [self.view addSubview:label];
    
    UILabel *labels = [[UILabel alloc]init];
    labels.frame = CGRectMake(20, 199, kScreen_w - 40, 1);
    //    label.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    labels.backgroundColor = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1];
    [self.view addSubview:labels];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor colorWithRed:215.0/255.0 green:76.0/255.0 blue:110.0/255.0 alpha:1];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.frame = CGRectMake(40,240, kScreen_w - 80, 40);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(addbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//年龄选择
- (void)addageButton:(UIButton *)sender{
    
}

- (void)addbutton:(UIButton *)sender{
    PerfectViewController *PerfectView = [[PerfectViewController alloc]init];
    PerfectView.xingString = self.xingString;
//    PerfectView.dic = dic;
//    UINavigationController *PerfectViewNC = [[UINavigationController alloc] initWithRootViewController:PerfectView];
    [self.navigationController pushViewController:PerfectView animated:YES];
    
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
