//
//  LCMessageListVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCUserMessageListVC.h"
#import "LCNoticeSettingVC.h"
#import "LCMessageForMeView.h"
#import "LCMessageForSystemView.h"
@interface LCUserMessageListVC ()
{
    BOOL _isChange;
    BOOL _isJumpSetting;
    LCMessageForMeView *_meView;
    
}
@property (nonatomic, weak) LCMessageForSystemView *systemView;
@end

@implementation LCUserMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRedNavigationBackButton];
    [self backToWhiteNavigationColor];
    [self addRightNavigationButtonWithNornalImage:@"settingicon" seletedIamge:nil target:self action:@selector(settingClick)];
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
    if (!_isJumpSetting && _isChange){
        [self backToWhiteNavigationColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(!_isJumpSetting){
        _isChange = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorUtilsString(kNavigationTitle_Color),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
    }else {
        _isJumpSetting = NO;
    }
}
- (void)settingClick {
    _isJumpSetting = YES;
    LCNoticeSettingVC *setting = [[LCNoticeSettingVC alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
- (void)changeShowClick:(UISegmentedControl *)segment {
    if(segment.selectedSegmentIndex == 0) {
        self.systemView.hidden = YES;
        _meView.hidden = NO;
    }else {
        self.systemView.hidden = NO;
        _meView.hidden = YES;
    }
}
- (void)initializeMainView {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"@我的",@"系统消息"]];
    segmentedControl.frame = CGRectMake(0, (self.navibarHeight - 31) / 2.0, 274, 31);
    segmentedControl.tintColor = ColorRGBA(230, 0, 18, 1.0);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(changeShowClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
    _meView = [[LCMessageForMeView alloc]init];
    [self.view addSubview:_meView];
    [_meView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    [_meView loadFirstData];
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
