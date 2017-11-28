//
//  LCPushGuessViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCPushGuessViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong) RACSignal *contentSignal;
@property (nonatomic, strong) RACSignal *titleSignal;
- (void)bindInputSignal;
- (void)pushGuessEvent:(NSString *)answer;
@end
