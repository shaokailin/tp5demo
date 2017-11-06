//
//  PPSSLoginViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSLoginViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *accountSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) RACSignal *rememberSignal;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger loginErrorCount;
@property (nonatomic, copy) NSString *codeString;
//绑定登录的文本信号和信号
- (void)bindLoginSignal;
//登录事件
- (void)userLoginClickEvent;
//发送短信验证码事件
- (void)sendLoginCode;
@end
