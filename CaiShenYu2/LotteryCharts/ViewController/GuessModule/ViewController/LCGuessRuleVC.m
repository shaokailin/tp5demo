//
//  LCGuessRuleVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessRuleVC.h"

@interface LCGuessRuleVC ()

@end

@implementation LCGuessRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBackButton];
    self.navigationItem.title = @"擂台规则";
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
