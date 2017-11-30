//
//  LCPushPostViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCPushPostViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *titleSignal;
@property (nonatomic, strong) RACSignal *contentSignal;
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, copy) NSString *showMoney;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, assign) BOOL isVoice;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) RACSignal *vipSignal;
- (void)bindPushPostSignal;
- (void)delectMedia:(NSInteger)type index:(NSInteger)index;
- (void)pushPostActionEvent;
@end
