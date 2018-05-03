//
//  LCTeamCountModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCTeamCountModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *teamcount;
@property (nonatomic, copy) NSString *onlinecount;

@property (nonatomic, copy) NSString *sign_count;
@property (nonatomic, copy) NSString *sign_ymoney;

@end
