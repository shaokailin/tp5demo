//
//  PPSSLoginMainVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginMainVC.h"
#import "PPSSLoginMainView.h"
#import "PPSSLoginViewModel.h"
@interface PPSSLoginMainVC ()
@property (nonatomic, weak) PPSSLoginMainView *loginView;
@property (nonatomic, strong) PPSSLoginViewModel *loginViewModel;
@end

@implementation PPSSLoginMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
}
- (void)initializeMainView {
    self.title = kLogin_Title_Name;
    PPSSLoginMainView *loginView = [[PPSSLoginMainView alloc]init];
    _loginView = loginView;
    [self.view addSubview:loginView];
    WS(ws)
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
}
- (void)bindSignal {
    _loginViewModel = [[PPSSLoginViewModel alloc]init];
    _loginViewModel.rememberSignal = RACObserve(self.loginView,rememberPwd);
    _loginViewModel.passwordSignal = self.loginView.passwordField.textSignal;
    _loginViewModel.accountSignal = self.loginView.accountField.textSignal;
    [_loginViewModel bindLoginSignal];
    @weakify(self)
    [[_loginView.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.loginViewModel userLoginClickEvent];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
