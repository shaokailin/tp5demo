//
//  PPSSForgetPwdVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSForgetPwdVC.h"
#import "PPSSForgetMainView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "PPSSForgetPwdViewModel.h"
@interface PPSSForgetPwdVC ()
@property (nonatomic, weak) PPSSForgetMainView *mainView;
@property (nonatomic, strong) PPSSForgetPwdViewModel *viewModel;
@end

@implementation PPSSForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)initializeMainView {
    self.title = kForgetPassword_Title_Name;
    TPKeyboardAvoidingScrollView *scrollerView = [LSKViewFactory initializeTPScrollView];
    [self.view addSubview:scrollerView];
    WS(ws)
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, self.viewMainHeight);
    PPSSForgetMainView *mainView = [[PPSSForgetMainView alloc]init];
    _mainView = mainView;
    [scrollerView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollerView).with.offset(15);
        make.right.equalTo(ws.view).with.offset(-15);
        make.height.mas_equalTo(ws.viewMainHeight - 30);
    }];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSForgetPwdViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
       [self performSelector:@selector(backToLogin) withObject:nil afterDelay:1.25];
    } failure:nil];
    _viewModel.codeSignal = self.mainView.codeField.rac_textSignal;
    _viewModel.passwordSignal = self.mainView.passwordField.textSignal;
    _viewModel.accountSignal = self.mainView.accountField.textSignal;
    [_viewModel bindForgetSignal];
    
    [[_mainView.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.view endEditing:YES];
       [self.viewModel ChangeForgetPwdEvent];
    }];
    
    [[RACObserve(self.mainView,isGetCode)skip:1]subscribeNext:^(NSNumber *isCode) {
        if ([isCode integerValue] == 1) {
            [self.view endEditing:YES];
            [self.viewModel sendForgetCode];
        }
    }];
}
- (void)backToLogin {
    [self.navigationController popViewControllerAnimated:YES];
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
