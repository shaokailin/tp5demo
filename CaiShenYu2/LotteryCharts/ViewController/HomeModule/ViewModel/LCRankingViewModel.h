//
//  LCRankingViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCHomeRankingListModel.h"
#import "LCRankingVipListModel.h"
#import "LCRankingRenListModel.h"
@interface LCRankingViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, assign) NSInteger page;
//@property (nonatomic, assign) NSArray *topArray;
@property (nonatomic, strong) NSMutableArray *postArray;
- (void)getRankingList:(BOOL)isPull;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *postId;
- (void)upPostViewRanging;
@end
