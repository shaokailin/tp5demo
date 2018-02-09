//
//  LCLoginMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLoginMainVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LCLoginMainView.h"
#import "LCForgetPWDVC.h"
#import "LCRegisterMainVC.h"
#import "LCLoginViewModel.h"
#import <UMSocialCore/UMSocialCore.h>
@interface LCLoginMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCLoginMainView *loginView;
@property (nonatomic, strong) LCLoginViewModel *viewModel;
@end

@implementation LCLoginMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return self.isHidenNavi;
}
- (void)loginActionWithType:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else if (type == 3){
        [self.viewModel loginEventClick];
    }else if (type == 2 || type == 4) {
        UIViewController *controller = nil;
        if (type == 2) {
            LCForgetPWDVC *forget = [[LCForgetPWDVC alloc]init];
            controller = forget;
        }else {
            LCRegisterMainVC *registerVC = [[LCRegisterMainVC alloc]init];
            controller = registerVC;
        }
        if (!_isHidenNavi) {
            controller.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:controller animated:YES];
    }else if (type == 5) {
        if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
            self.viewModel.loginType = @"weixin";
            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        }else {
            [SKHUD showMessageInWindowWithMessage:@"暂无条件使用微信快捷登录"];
        }
    }else if (type == 6) {
        if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
            self.viewModel.loginType = @"qq";
            [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
        }else {
            [SKHUD showMessageInWindowWithMessage:@"暂无条件使用QQ快捷登录"];
        }
    }
}
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (!error) {
            UMSocialUserInfoResponse *resp = result;
            [self.viewModel loginWithThird:resp.uid loginName:resp.name loginSex:resp.unionGender userPhoto:resp.iconurl];
        }else {
            [SKHUD showMessageInWindowWithMessage:@"授权失败~!"];
        }
    }];
}

- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCLoginViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    } failure:nil];
    _viewModel.phoneSignal = self.loginView.accountField.rac_textSignal;
    _viewModel.pwdSignal = self.loginView.passwordField.rac_textSignal;
    [_viewModel bindLoginSignal];
}
#pragma mark 界面初始化
- (void)initializeMainView {
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    WS(ws)
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    LCLoginMainView *loginView = [[[NSBundle mainBundle] loadNibNamed:@"LCLoginMainView" owner:self options:nil] lastObject];
    loginView.loginBlock = ^(NSInteger type) {
        [ws loginActionWithType:type];
    };
    self.loginView = loginView;
    [mainScrollerView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [loginView hidenBackBtn:_isHidenNavi];
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
