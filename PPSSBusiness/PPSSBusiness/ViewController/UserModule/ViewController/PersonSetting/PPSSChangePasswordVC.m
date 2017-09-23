//
//  PPSSChangePasswordVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSChangePasswordVC.h"
#import "PPSSChangePasswordView.h"
@interface PPSSChangePasswordVC ()
@property (nonatomic, weak)PPSSChangePasswordView *passwordView;
@end

@implementation PPSSChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)initializeMainView {
    self.title = kChangePwd_Title_Name;
    PPSSChangePasswordView *password = [[PPSSChangePasswordView alloc]init];
    self.passwordView = password;
    [self.view addSubview:password];
    WS(ws)
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
