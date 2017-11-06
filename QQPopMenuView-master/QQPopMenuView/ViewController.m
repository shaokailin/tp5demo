//
//  ViewController.m
//  QQPopMenuView
//
//  Created by ec on 2016/11/15.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ViewController.h"
#import "QQPopMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popMenu:(UIButton *)sender {
    [QQPopMenuView showWithItems:@[@{@"title":@"发起讨论"},
                                   @{@"title":@"扫描名片"},
                                   @{@"title":@"写日报"},
                                   @{@"title":@"外勤签到"}]
                           width:130
                triangleLocation:CGPointMake([UIScreen mainScreen].bounds.size.width-30, 64+5)
                          action:^(NSInteger index) {
                              NSLog(@"点击了第%ld行",index);
    }];
}

@end
