//
//  LCUserHomeMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCUserMessageModel.h"
@interface LCUserHomeMessageModel : LSKBaseResponseModel
@property (nonatomic, strong) LCUserMessageModel *user_info;
@property (nonatomic, copy) NSString *follow_count;
@property (nonatomic, copy) NSString *team_count;
@end
