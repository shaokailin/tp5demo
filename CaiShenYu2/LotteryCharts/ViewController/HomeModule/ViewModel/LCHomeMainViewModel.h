//
//  LCHomeMainViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCHomeHotListModel.h"
#import "LCHomeHeaderMessageModel.h"
#import "LCPostDetailModel.h"
@interface LCHomeMainViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *hotPostArray;
@property (nonatomic, strong) LCHomeHeaderMessageModel *messageModel;
- (void)bindSinal;
- (void)getHomeMessage:(BOOL)isPull;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, assign) NSInteger searchType;
- (void)searchPostEvent:(NSString *)test;
@end
