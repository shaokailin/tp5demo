//
//  PPSSWebVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWebVC.h"
#import "LSKActionSheetView.h"
@interface PPSSWebVC ()

@end

@implementation PPSSWebVC

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
