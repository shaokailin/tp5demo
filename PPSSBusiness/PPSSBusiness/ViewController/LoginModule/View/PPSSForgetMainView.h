//
//  PPSSForgetMainView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSSLoginInputView.h"
#import "PPSSLoginCodeView.h"
@interface PPSSForgetMainView : UIView
@property (nonatomic, weak) PPSSLoginInputView *accountField;
@property (nonatomic, weak) PPSSLoginInputView *passwordField;
@property (nonatomic, weak) PPSSLoginCodeView *codeField;
@property (nonatomic, weak) UIButton *sureBtn;
@property (nonatomic, assign) BOOL isGetCode;
@end
