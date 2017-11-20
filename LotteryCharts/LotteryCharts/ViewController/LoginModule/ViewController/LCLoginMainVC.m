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
@interface LCLoginMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCLoginMainView *loginView;
@end

@implementation LCLoginMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initializeMainView];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return self.isHidenNavi;
}
#pragma mark 界面初始化
- (void)initializeMainView {
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    WS(ws)
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0,ws.isHidenNavi? ws.tabbarBetweenHeight : 0, 0));
    }];
    CGFloat contentHeight = 635 > SCREEN_HEIGHT ? 635 : SCREEN_HEIGHT;
    LCLoginMainView *loginView = [[[NSBundle mainBundle] loadNibNamed:@"LCLoginMainView" owner:self options:nil] lastObject];
    self.loginView = loginView;
    [mainScrollerView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
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
