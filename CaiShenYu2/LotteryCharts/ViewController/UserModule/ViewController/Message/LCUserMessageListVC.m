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
#import "LCMessageListVM.h"
@interface LCUserMessageListVC ()
{
    BOOL _isChange;
    BOOL _isJumpSetting;
    
    UISegmentedControl *_segmentedControl;
}
@property (nonatomic, strong) LCMessageListVM *viewModel;
@property (nonatomic, weak) LCMessageForSystemView *systemView;
@property (nonatomic, weak) LCMessageForMeView *meView;
@end

@implementation LCUserMessageListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRedNavigationBackButton];
    [self addRightNavigationButtonWithNornalImage:@"settingicon" seletedIamge:nil target:self action:@selector(settingClick)];
    [self initializeMainView];
}
- (LCMessageListVM *)viewModel {
    if (!_viewModel) {
        @weakify(self)
        _viewModel = [[LCMessageListVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
            [self settingClick];
        } failure:^(NSUInteger identifier, NSError *error) {
            
        }];
    }
    return _viewModel;
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
    if (!_isJumpSetting && !_isChange){
        [self backToWhiteNavigationColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
    _isJumpSetting = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(!_isJumpSetting){
        _isChange = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorUtilsString(kNavigationTitle_Color),NSFontAttributeName : FontNornalInit(kNavigationTitle_Font)};
        [self backToNornalNavigationColor];
    }else {
        _isJumpSetting = YES;
    }
}
- (void)settingClick {
    if (!_viewModel || !_viewModel.model) {
        [self.viewModel getUserNoticeSetting];
    }else {
        _isJumpSetting = YES;
        LCNoticeSettingVC *setting = [[LCNoticeSettingVC alloc]init];
        setting.model = self.viewModel.model;
        [self.navigationController pushViewController:setting animated:YES];
    }
    
}
- (void)changeShowClick:(UISegmentedControl *)segment {
    if(segment.selectedSegmentIndex == 0) {
        self.systemView.hidden = YES;
        self.meView.hidden = NO;
    }else {
        self.systemView.hidden = NO;
        _meView.hidden = YES;
    }
}
- (void)selectIndex:(NSInteger)index {
    if (!_segmentedControl) {
        _selectIndex = index;
    }
    _segmentedControl.selectedSegmentIndex = index;
    if(_segmentedControl.selectedSegmentIndex == 0) {
        self.systemView.hidden = YES;
        self.meView.hidden = NO;
    }else {
        self.systemView.hidden = NO;
        _meView.hidden = YES;
    }
}
- (void)reloadIndex {
    if(_segmentedControl.selectedSegmentIndex == 0) {
        [_meView loadFirstData];
    }else {
        if (_systemView) {
            [_systemView loadFirstData];
        }
    }
}
- (void)initializeMainView {
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"@我的",@"系统消息"]];
    _segmentedControl.frame = CGRectMake(0, (self.navibarHeight - 31) / 2.0, 274, 31);
    _segmentedControl.tintColor = ColorRGBA(230, 0, 18, 1.0);
    _segmentedControl.selectedSegmentIndex = self.selectIndex;
    [_segmentedControl addTarget:self action:@selector(changeShowClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    if (self.selectIndex == 0) {
        self.meView.hidden = NO;
    }else {
        self.systemView.hidden = NO;
    }
    
}
- (LCMessageForMeView *)meView {
    if (!_meView) {
        LCMessageForMeView *meView = [[LCMessageForMeView alloc]init];
        _meView = meView;
        [self.view addSubview:meView];
        [meView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
        }];
        [meView loadFirstData];
    }
    return _meView;
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
