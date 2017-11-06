//
//  PPSSPunchCardRecordVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/11/4.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPunchCardRecordVC.h"
#import "PPSSPunchCardHeadView.h"
#import "PPSSPunchCardCalendarView.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface PPSSPunchCardRecordVC ()
@property (nonatomic, weak) PPSSPunchCardHeadView *headerView;
@property (nonatomic, weak) PPSSPunchCardCalendarView *calendarView;
@end

@implementation PPSSPunchCardRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
}

- (void)initializeMainView {
    self.title = kPunchCard_Title_Name;
    TPKeyboardAvoidingScrollView *scrollView = [LSKViewFactory initializeTPScrollView];
    [self.view addSubview:scrollView];
    WS(ws)
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];

    PPSSPunchCardHeadView *headerView = [[PPSSPunchCardHeadView alloc]init];
    self.headerView = headerView;
    [scrollView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(176);
    }];
    
    CGFloat contentHeight = 176;
    PPSSPunchCardCalendarView *calendarView = [[PPSSPunchCardCalendarView alloc]init];
    self.calendarView = calendarView;
    [scrollView addSubview:calendarView];
    [calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.top.equalTo(headerView.mas_bottom);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(398);
    }];
    contentHeight += 420;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
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
