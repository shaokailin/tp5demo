//
//  LCTeamListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamListModel.h"

@implementation LCTeamListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCTeamModel class],
             };
}
@end
@implementation LCTeamModel

@end
