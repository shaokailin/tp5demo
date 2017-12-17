//
//  LCSearchPostViewModel.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCHomePostModel.h"
#import "LCHomeHotListModel.h"
@interface LCSearchPostViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) NSMutableArray *searchArray;
- (void)getSearchResult;
@end
