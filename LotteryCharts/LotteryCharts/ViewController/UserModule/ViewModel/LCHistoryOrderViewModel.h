//
//  LCHistoryOrderViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCHistoryOrderListModel.h"
#import "LCOrderHistoryGuessModel.h"
@interface LCHistoryOrderViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, strong) NSMutableArray *historyArray;
- (void)getHistoryOrderList:(BOOL)isPull;
@end
