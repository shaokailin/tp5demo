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
//绑定登录的文本信号和信号
- (void)bindLoginSignal;
- (void)userLoginClickEvent;
@end
