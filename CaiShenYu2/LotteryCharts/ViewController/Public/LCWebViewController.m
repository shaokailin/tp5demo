//
//  LCWebViewController.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWebViewController.h"
@interface LCWebViewController ()

@end

@implementation LCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)initializeMainView {
    [self changeWebFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight - self.tabbarBetweenHeight)];
    if (KJudgeIsNullData(self.titleString)) {
        self.title = self.titleString;
    }else {
        @weakify(self)
        self.titleBlock = ^(NSString *title) {
            @strongify(self)
            self.title = title;
        };
    }
    self.isShowBack = YES;
    self.isGetJsBrirge = NO;
    self.isShowProgress = YES;
    [self loadMainWebViewUrl:self.loadUrl];
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
