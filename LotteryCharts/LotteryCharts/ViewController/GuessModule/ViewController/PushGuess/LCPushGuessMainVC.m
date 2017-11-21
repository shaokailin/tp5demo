//
//  LCPushGuessMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPushGuessMainVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LCGuessInputView.h"
#import "LCGuessSelectView.h"
@interface LCPushGuessMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCGuessInputView *inputView;
@property (nonatomic, weak) LCGuessSelectView *selectView;
@end

@implementation LCPushGuessMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布竞猜";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)showRule {
    
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"规则" target:self action:@selector(showRule)];
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    LCGuessInputView *inputView = [[[NSBundle mainBundle] loadNibNamed:@"LCGuessInputView" owner:self options:nil] lastObject];
    self.inputView = inputView;
    [mainScrollerView addSubview:inputView];
    WS(ws)
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(163);
    }];
    
    LCGuessSelectView *selectView = [[LCGuessSelectView alloc]initWithFrame:CGRectMake(0, 173, SCREEN_WIDTH, 397)];
    self.selectView = selectView;
    [mainScrollerView addSubview:selectView];
    
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight , 0));
    }];
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 173 + 397 + 20);
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
