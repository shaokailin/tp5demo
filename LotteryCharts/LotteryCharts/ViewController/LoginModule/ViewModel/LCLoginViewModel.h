//
//  LCLoginViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCLoginViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *phoneSignal;
@property (nonatomic, strong) RACSignal *pwdSignal;
- (void)bindLoginSignal;
- (void)loginEventClick;

@property (nonatomic, strong) RACSignal *codeSignal;
@property (nonatomic, strong) RACSignal *mchidSignal;
- (void)bindRegisterSignal;
- (void)registerActionEvent;

- (void)bindForgetSignal;
- (void)forgetActionEvent;

- (void)getCodeEvent;
@end
