//
//  LCSpaceViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCSpacePostListModel.h"
#import "LCSpaceGuessListModel.h"
#import "LCSpaceSendRecordListModel.h"
@interface LCSpaceViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)attentionUserClick;
- (void)getSpaceData:(BOOL)isPull;
@end
