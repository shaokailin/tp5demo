//
//  LCSystemMessageVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/6/15.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCSystemMessageVC.h"
#import "LCMessageForSystemView.h"
@interface LCSystemMessageVC ()
{
    BOOL _isChange;
}
@property (nonatomic, weak) LCMessageForSystemView *systemView;
@end

@implementation LCSystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"系统消息";
     [self addRedNavigationBackButton];
    [self initializeMainView];
}
- (void)backToWhiteNavigationColor {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : ColorRGBA(230, 0, 18, 1.0),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isChange){
        [self backToWhiteNavigationColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isChange = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorUtilsString(kNavigationTitle_Color),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
    [self backToNornalNavigationColor];
}
- (void)initializeMainView {
    self.systemView.hidden = NO;
}
- (LCMessageForSystemView *)systemView {
    if (!_systemView) {
        LCMessageForSystemView *systemView = [[LCMessageForSystemView alloc]init];
        _systemView = systemView;
        [self.view addSubview:systemView];
        [systemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
        }];
        [systemView loadFirstData];
    }
    return _systemView;
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
