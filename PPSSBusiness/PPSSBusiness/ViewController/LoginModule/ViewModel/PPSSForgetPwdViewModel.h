//
//  PPSSForgetPwdViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSForgetPwdViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *accountSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) RACSignal *codeSignal;
//绑定的文本信号和信号
- (void)bindForgetSignal;
//修改事件
- (void)ChangeForgetPwdEvent;
//发送短信验证码事件
- (void)sendForgetCode;
@end
