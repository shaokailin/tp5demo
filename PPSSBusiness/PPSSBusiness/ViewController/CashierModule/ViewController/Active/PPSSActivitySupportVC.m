//
//  PPSSActivitySupportVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivitySupportVC.h"

@interface PPSSActivitySupportVC ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@end

@implementation PPSSActivitySupportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kActivitySupport_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.textField resignFirstResponder];
}
- (void)saveChangeSupport {
    if (self.block) {
        self.block(self.textField.text);
    }
    [self navigationBackClick];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"wancheng_ico" seletedIamge:nil target:self action:@selector(saveChangeSupport)];
    self.view.backgroundColor = COLOR_WHITECOLOR;
    UITextField *textField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入活动力度" textFont:12 textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_9999, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeNumberPad cleanModel:0];
    self.textField = textField;
    [self.view addSubview:textField];
    WS(ws)
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).with.offset(15);
        make.right.equalTo(ws.view).with.offset(-15);
        make.top.equalTo(ws.view).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textField);
        make.top.equalTo(textField.mas_bottom);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    UILabel *remarkLbl = [PPSSPublicViewManager initLblForColor9999:@"信息提示:活动力度的区间是0-100之间，请慎重填写"];
    [self.view addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).with.offset(12);
    }];
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
