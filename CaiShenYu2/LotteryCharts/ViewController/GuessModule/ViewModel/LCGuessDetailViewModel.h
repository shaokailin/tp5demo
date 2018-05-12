//
//  LCGuessDetailViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCPostReplyListModel.h"
#import "LCGuessDetailModel.h"
#import "LCReplySuccessModel.h"
@interface LCGuessDetailViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, copy) NSString *quiz_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *target;

@property (nonatomic, strong) NSMutableArray *replyArray;
- (void)getReplyList:(BOOL)isPull;
- (void)sendReplyClick:(NSString *)message;
- (void)betGuessWithCount:(NSString *)count;
@end
