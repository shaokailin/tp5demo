//
//  LCGuessHistoryViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCGuessMainListModel.h"
@interface LCGuessHistoryViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *guessArray;
- (void)getGuessHistoryList:(BOOL)isPull;
@end
