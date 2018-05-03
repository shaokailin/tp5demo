//
//  LCTeamViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCTeamCountModel.h"
#import "LCTeamListModel.h"
#import "LCBaseResponseModel.h"
@interface LCTeamViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *teamArray;
@property (nonatomic, assign) NSInteger showType;
- (void)bindSinal;
- (void)getTeamList:(BOOL)isPull;
@end
