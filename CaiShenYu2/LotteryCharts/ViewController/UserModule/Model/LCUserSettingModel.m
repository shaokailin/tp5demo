//
//  LCUserSettingModel.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/23.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCUserSettingModel.h"

@implementation LCUserSettingModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"comment_reply" : @"response.comment_reply",
             @"focus" : @"response.focus",
             @"reward" : @"response.reward",
             @"system" : @"response.system"
             };
}
@end
