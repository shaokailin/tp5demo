//
//  PPSSChangePasswordVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSChangePasswordVC.h"
#import "PPSSChangePasswordView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "PPSSChangePwdViewModel.h"
@interface PPSSChangePasswordVC ()
@property (nonatomic, weak)PPSSChangePasswordView *passwordView;
@property (nonatomic, strong) PPSSChangePwdViewModel *viewModel;

@end

@implementation PPSSChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSChangePwdViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self performSelector:@selector(backToLogin) withObject:nil afterDelay:1.25];
    } failure:nil];
    _viewModel.againPasswordSignal = self.passwordView.againPasswordField.rac_textSignal;
    _viewModel.passwordSignal = self.passwordView.passwordField.textSignal;
    _viewModel.oldSignal = self.passwordView.currentPasswordField.textSignal;
    [_viewModel bindChangeSignal];
    
    [[_passwordView.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.view endEditing:YES];
        [self.viewModel ChangePwdEvent];
    }];
}
- (void)backToLogin {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initializeMainView {
    self.title = kChangePwd_Title_Name;
    TPKeyboardAvoidingScrollView *scrollerView = [LSKViewFactory initializeTPScrollView];
    [self.view addSubview:scrollerView];
    scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, self.viewMainHeight);
    WS(ws)
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    PPSSChangePasswordView *password = [[PPSSChangePasswordView alloc]init];
    self.passwordView = password;
    [scrollerView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollerView).with.offset(15);
        make.right.equalTo(ws.view).with.offset(-15);
        make.height.mas_equalTo(ws.viewMainHeight - 30);
    }];
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
