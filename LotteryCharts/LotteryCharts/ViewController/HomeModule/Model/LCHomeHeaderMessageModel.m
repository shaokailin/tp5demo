//
//  LCHomeHeaderMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHeaderMessageModel.h"

@implementation LCHomeHeaderMessageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"adv_list" : [LCAdBannerModel class],
             @"notice" : [LCHomeNoticeModel class],
             @"period_list" : [LC3DLotteryModel class],
             };
    
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"adv_list" : @"response.adv_list",
             @"notice" : @"response.notice",
             @"period_list" : @"response.period_list",
             };
}
@end
