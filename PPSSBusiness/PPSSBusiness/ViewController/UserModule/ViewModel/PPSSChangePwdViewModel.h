//
//  PPSSChangePwdViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSChangePwdViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *oldSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) RACSignal *againPasswordSignal;
//绑定的文本信号和信号
- (void)bindChangeSignal;
//修改事件
- (void)ChangePwdEvent;
@end
