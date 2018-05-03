//
//  LCForgetPWDVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCForgetPWDVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LCForgetPWDView.h"
#import "LCLoginViewModel.h"
@interface LCForgetPWDVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCForgetPWDView *forgetView;
@property (nonatomic, strong) LCLoginViewModel *viewModel;
@end

@implementation LCForgetPWDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)forgetActionWithType:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else if (type == 2){
        [self.viewModel getCodeEvent];
    }else {
        [self.viewModel forgetActionEvent];
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCLoginViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 2) {
            [kUserMessageManager startForgetTimer];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"修改成功~!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:nil];
    _viewModel.phoneSignal = self.forgetView.accountField.rac_textSignal;
    _viewModel.pwdSignal = self.forgetView.passwordFild.rac_textSignal;
    _viewModel.codeSignal = self.forgetView.codeField.rac_textSignal;
    _viewModel.mchidSignal = self.forgetView.againPwdField.rac_textSignal;
    [_viewModel bindForgetSignal];
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
    CGFloat contentHeight = 400 > self.viewMainHeight ? 400 : self.viewMainHeight;
    LCForgetPWDView *forgetView = [[[NSBundle mainBundle] loadNibNamed:@"LCForgetPWDView" owner:self options:nil] lastObject];
    forgetView.forgetBlock = ^(NSInteger type) {
        [ws forgetActionWithType:type];
    };
    self.forgetView = forgetView;
    [mainScrollerView addSubview:forgetView];
    [forgetView mas_makeConstraints:^(MASConstraintMaker *make) {
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
