//
//  LCExchangeMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCExchangeMainVC.h"
#import "LCExchangeMoneyViewModel.h"
@interface LCExchangeMainVC ()<UITextFieldDelegate>
{
    BOOL _isChange;
}
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property (weak, nonatomic) IBOutlet UILabel *yinbiLbl;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, strong) LCExchangeMoneyViewModel *viewModel;
@end

@implementation LCExchangeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"金币兑换";
    [self backToNornalNavigationColor];
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCExchangeMoneyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        
    } failure:nil];
    
    [[self.moneyField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        NSInteger number = [x integerValue];
        self.viewModel.glodMoney = number;
        self.yinbiLbl.text = NSStringFormat(@"%zd银币",number * 100);
    }];
}
- (void)initializeMainView {
    ViewRadius(self.sureBtn, 5.0);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)sureClick:(id)sender {
    [self.view endEditing:YES];
    [self.viewModel glodExchangeSilverEvent];
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
