//
//  CustomerViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.dataDic[@"url"]]]];
//    webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:webView];

}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
   [self.navigationController popViewControllerAnimated:nil];
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
