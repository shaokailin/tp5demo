//
//  LCHistoryLotteryViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCHistoryLotteryListModel.h"
@interface LCHistoryLotteryViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger limitRow;
@property (nonatomic, strong) NSMutableArray *historyArray;
- (void)getHistoryLotteryList:(BOOL)isPull;
@end
