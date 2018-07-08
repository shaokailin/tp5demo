//
//  TXXLWeatherCenterVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLWeatherCenterVC.h"
#import "MMDrawerController.h"
#import "TXXLWeatherCityListVC.h"
#import "TXXLWeatherDetailVC.h"
#import "TXXLWeatherCitySelectVC.h"
@interface TXXLWeatherCenterVC ()
@property (nonatomic, strong) NSMutableArray *weatherData;
@property (nonatomic, strong) MMDrawerController *drawerVC;
@property (nonatomic, weak) TXXLWeatherCityListVC *listVC;
@property (nonatomic, weak) TXXLWeatherDetailVC *detailVC;
@end

@implementation TXXLWeatherCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (BOOL)fd_interactivePopDisabled {
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; //返回白色
}

- (void)detailEventClick:(NSInteger)type data:(id)data {
    if (type == 0) {
        [self.drawerVC openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else if (type == 1){
        [self.navigationController popViewControllerAnimated:YES];
    }else if (type == 10){
        if (self.changeBlock) {
            self.changeBlock(1, data);
        }
    }
}
- (void)addCityClick:(NSInteger)type object:(id)object{
    [self.drawerVC closeDrawerAnimated:NO completion:nil];
    if (type == 0) {
        [self.detailVC listCityEvent:0 object:object];
    }else {
        [self.detailVC listCityEvent:1 object:nil];
        [self.listVC refreshData];
    }
}
- (void)listEventClick:(NSInteger)type data:(id)data{
    if (type == 2) {
        [self.drawerVC closeDrawerAnimated:YES completion:nil];
        [self.detailVC listCityEvent:0 object:data];
    }else if (type == 1){
        @weakify(self)
        TXXLWeatherCitySelectVC *select = [[TXXLWeatherCitySelectVC alloc]init];
        select.addBlock = ^(NSInteger type, id object) {
            @strongify(self)
            [self addCityClick:type object:object];
        };
        select.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:select animated:YES];
    }else if (type == 3){
        [self.drawerVC closeDrawerAnimated:YES completion:nil];
        [self.detailVC listCityEvent:2 object:data];
    }else if (type == 4){
        if (self.changeBlock) {
            self.changeBlock(1, data);
        }
    }
}
- (void)initializeMainView {
    TXXLWeatherDetailVC *detail = [[TXXLWeatherDetailVC alloc]init];
    @weakify(self)
    detail.detailBlock = ^(NSInteger eventTpye,id data) {
        @strongify(self)
        [self detailEventClick:eventTpye data:data];
    };
    self.detailVC = detail;
    TXXLWeatherCityListVC *list = [[TXXLWeatherCityListVC alloc]init];
    list.weatherDefaultDict = self.defaultData;
    list.listBlock = ^(NSInteger eventTpye,id object) {
        @strongify(self)
        [self listEventClick:eventTpye data:object];
    };
    self.listVC = list;
    _drawerVC = [[MMDrawerController alloc]initWithCenterViewController:detail leftDrawerViewController:list];
    _drawerVC.showsShadow = YES;
    _drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView|MMCloseDrawerGestureModeTapCenterView;
    _drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    _drawerVC.maximumLeftDrawerWidth = SCREEN_WIDTH - 60;
    [self addChildViewController:_drawerVC];
    _drawerVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_drawerVC.view];
    [_drawerVC didMoveToParentViewController:self];
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
