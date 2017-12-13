//
//  LCWithdrawViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCWithdrawRecordListModel.h"
@interface LCWithdrawViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *moneySignal;
- (void)bindSignal;
- (void)widthdrawActionEvent;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger mouth;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) NSMutableArray *historyArray;
- (void)getWidthdrawRecord:(BOOL)isPull;

@end
