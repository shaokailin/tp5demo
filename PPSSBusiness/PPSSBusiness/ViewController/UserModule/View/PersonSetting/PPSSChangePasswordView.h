//
//  PPSSChangePasswordView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSSLoginInputView.h"
@interface PPSSChangePasswordView : UIView
@property (nonatomic, weak) PPSSLoginInputView *passwordField;
@property (nonatomic, weak) PPSSLoginInputView *againPasswordField;
@property (nonatomic, weak) PPSSLoginInputView *currentPasswordField;
@property (nonatomic, weak) UIButton *sureBtn;
@end
