//
//  LCUserNoticeVM.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCUserMessageListModel.h"
@interface LCUserNoticeVM : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *listArray;
-(void)getUserNoticeList:(BOOL)isPull;
- (void)getSystemNoticeList:(BOOL)isPull;
@end
