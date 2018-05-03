//
//  LCGuessMainListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCGuessModel.h"
@interface LCGuessMainModel :NSObject
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, copy) NSString *betting_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *lottery_result_size;
@property (nonatomic, copy) NSString *lottery_result_kill;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *open_status;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *period_count;
@property (nonatomic, strong) NSArray *quiz_list;
@end;
@interface LCGuessMainListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
