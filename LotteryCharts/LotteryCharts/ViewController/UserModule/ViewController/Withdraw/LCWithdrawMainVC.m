//
//  LCWithdrawMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawMainVC.h"
#import "LCWithdrawRecordVC.h"
@interface LCWithdrawMainVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation LCWithdrawMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"赏金提现";
    [self addNavigationBackButton];
    [self addRightNavigationButtonWithTitle:@"记录" target:self action:@selector(showRecordVC)];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self backToNornalNavigationColor];
}
- (IBAction)surePayClick:(id)sender {
    [self.moneyField resignFirstResponder];
}
- (IBAction)contactServiceClick:(id)sender {
    [self.moneyField resignFirstResponder];
}

- (void)showRecordVC {
    [self.moneyField resignFirstResponder];
    LCWithdrawRecordVC *recordVC = [[LCWithdrawRecordVC alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
- (void)initializeMainView {
    ViewRadius(self.sureBtn, 5.0);
    self.moneyField.rightViewMode = UITextFieldViewModeAlways;
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"金币" font:12 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:1 backgroundColor:nil];
    titleLbl.frame = CGRectMake(0, 0, 45, 35);
    self.moneyField.rightView = titleLbl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.moneyField resignFirstResponder];
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
