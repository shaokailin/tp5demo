//
//  PPSSLoginMainView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSSLoginInputView.h"
@interface PPSSLoginMainView : UIView
@property (nonatomic, weak) PPSSLoginInputView *accountField;
@property (nonatomic, weak) PPSSLoginInputView *passwordField;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, assign) BOOL rememberPwd;
@end
