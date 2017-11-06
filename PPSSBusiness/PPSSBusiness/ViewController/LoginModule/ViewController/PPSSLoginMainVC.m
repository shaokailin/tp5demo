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
#import "PPSSForgetPwdVC.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"
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
    WS(ws)
    TPKeyboardAvoidingScrollView *scrollerView = [LSKViewFactory initializeTPScrollView];
    [self.view addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
         LSKLog(@"%f",ws.tabbarBetweenHeight);
        make.edges.equalTo(ws.view);
    }];
    CGFloat contentHeight = self.viewMainHeight > 530 ? self.viewMainHeight:530;
    scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    PPSSLoginMainView *loginView = [[PPSSLoginMainView alloc]init];
    _loginView = loginView;
    [scrollerView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollerView).with.offset(15);
        make.right.equalTo(ws.view).with.offset(-15);
        make.height.mas_equalTo(contentHeight - 30);
    }];
}
- (void)bindSignal {
     @weakify(self)
    _loginViewModel = [[PPSSLoginViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (self.inType == LoginMainInType_Token) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [((AppDelegate *)[UIApplication sharedApplication].delegate )windowRootControllerChange:YES];
        }
    } failure:nil];
    _loginViewModel.type = self.inType;
    _loginViewModel.rememberSignal = RACObserve(self.loginView,rememberPwd);
    _loginViewModel.passwordSignal = self.loginView.passwordField.textSignal;
    _loginViewModel.accountSignal = self.loginView.accountField.textSignal;
    [self.loginView bindErrorSignal:[[RACObserve(self.loginViewModel, loginErrorCount) skip:1] distinctUntilChanged]];
    [_loginViewModel bindLoginSignal];
   
    [[_loginView.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.view endEditing:YES];
        if (self.loginViewModel.loginErrorCount >= 5) {
            self.loginViewModel.codeString = self.loginView.codeField.text;
        }
        [self.loginViewModel userLoginClickEvent];
    }];
    
    [[RACObserve(self.loginView,isGetCode)skip:1]subscribeNext:^(NSNumber *isCode) {
        if ([isCode integerValue] == 1) {
            [self.view endEditing:YES];
            [self.loginViewModel sendLoginCode];
        }
    }];
    [[_loginView.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self jumpForgetPassword];
    }];
}
- (void)jumpForgetPassword {
    [self.view endEditing:YES];
    PPSSForgetPwdVC *forget = [[PPSSForgetPwdVC alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
