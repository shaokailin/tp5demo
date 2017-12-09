//
//  LCGuessMainViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCGuessMainListModel.h"
#import "LCGuessMainMoreModel.h"
@interface LCGuessMainViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *guessArray;
- (void)getGuessMianList:(BOOL)isPull;
@property (nonatomic, copy) NSString *period_id;
- (void)getGuessMainMoreList:(BOOL)isPull;
@end
