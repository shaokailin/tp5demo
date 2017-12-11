//
//  LC3DLotteryModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC3DLotteryModel : NSObject
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, copy) NSString *betting_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *lottery_result_size;
@property (nonatomic, copy) NSString *lottery_result_kill;
@property (nonatomic, copy) NSString *open_status;
@property (nonatomic, copy) NSString *status;
@end
