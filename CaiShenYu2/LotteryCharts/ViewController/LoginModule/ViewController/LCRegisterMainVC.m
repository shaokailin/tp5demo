//
//  LCRegisterMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRegisterMainVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LCRegisterMainView.h"
#import "LCLoginViewModel.h"
#import <UMSocialCore/UMSocialCore.h>
@interface LCRegisterMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCRegisterMainView *registerView;
@property (nonatomic, strong) LCLoginViewModel *viewModel;
@end

@implementation LCRegisterMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeMainView];
    [self bindSignal];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)registerActionWithType:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else if(type == 2) {
        [self.viewModel getCodeEvent];
    }else if(type == 3) {
        [self.viewModel registerActionEvent];
    }else if(type == 4) {
        if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
            self.viewModel.loginType = @"weixin";
            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        }else {
            [SKHUD showMessageInWindowWithMessage:@"暂无条件使用微信快捷登录"];
        }
    }else if (type == 5) {
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
        if (identifier == 2) {
             [kUserMessageManager startLoginTimer];
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:nil];
    _viewModel.phoneSignal = self.registerView.accountField.rac_textSignal;
    _viewModel.pwdSignal = self.registerView.pwdField.rac_textSignal;
    _viewModel.codeSignal = self.registerView.codeField.rac_textSignal;
    _viewModel.mchidSignal = self.registerView.inviteField.rac_textSignal;
    [_viewModel bindRegisterSignal];
}
#pragma mark 界面初始化
- (void)initializeMainView {
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    WS(ws)
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight , 0));
    }];
    CGFloat contentHeight = 635 > SCREEN_HEIGHT ? 635 : SCREEN_HEIGHT;
    LCRegisterMainView *registerView = [[[NSBundle mainBundle] loadNibNamed:@"LCRegisterMainView" owner:self options:nil] lastObject];
    registerView.registerBlock = ^(NSInteger type) {
        [ws registerActionWithType:type];
    };
    self.registerView = registerView;
    [mainScrollerView addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(contentHeight);
    }];
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    
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
