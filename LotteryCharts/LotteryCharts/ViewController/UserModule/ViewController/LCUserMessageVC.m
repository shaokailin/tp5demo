//
//  LCUserMessageVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageVC.h"
#import "TPKeyboardAvoidingTableView.h"
@interface LCUserMessageVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@end

@implementation LCUserMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.title = @"个人信息";
    [self addRightNavigationButtonWithTitle:@"完成" target:self action:@selector(completeEdit)];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self backToNornalNavigationColor];
}
- (void)completeEdit {
    
}
#pragma mark -delegate

#pragma mark - init view
- (void)initializeMainView {
    TPKeyboardAvoidingTableView *tableview = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    
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
