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
#import "LCPushGuessViewModel.h"
@interface LCPushGuessMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCGuessInputView *inputView;
@property (nonatomic, weak) LCGuessSelectView *selectView;
@property (nonatomic, strong) LCPushGuessViewModel *viewModel;
@end

@implementation LCPushGuessMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布擂台";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)showRule {
    [self.view endEditing:YES];
}
- (void)bindSignal {
    _viewModel = [[LCPushGuessViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        
    } failure:nil];
    _viewModel.type = 2;
    _viewModel.titleSignal = self.inputView.titleField.rac_textSignal;
    _viewModel.contentSignal = self.inputView.contentField.rac_textSignal;
    [_viewModel bindInputSignal];
}
- (void)pushGuessAction {
    [self.view endEditing:YES];
    self.viewModel.money = [self.selectView getMoneyData];
    self.viewModel.number = [self.selectView getNumberData];
    [self.viewModel pushGuessEvent:[self.selectView getSelectData]];
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
    
    LCGuessSelectView *selectView = [[LCGuessSelectView alloc]initWithFrame:CGRectMake(0, 173, SCREEN_WIDTH, 417)];
    self.selectView = selectView;
    selectView.selectBlock = ^(NSInteger type) {
        [ws.view endEditing:YES];
        if (type == 2) {
         ws.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 173 + 417 + 20);
         ws.viewModel.type = 2;
        }else if (type == 3) {
            ws.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 173 + 369 + 20);
            ws.viewModel.type = 3;
        }else {
            [ws pushGuessAction];
        }
    };
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
