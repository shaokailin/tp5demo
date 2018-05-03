//
//  LCWeiPayOrderModel.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/2/9.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCWeiPayOrderModel.h"

@implementation LCWeiPayOrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"appid" : @"response.appid",
             @"noncestr" : @"response.noncestr",
             @"package" : @"response.package",
             @"partnerid" : @"response.partnerid",
             @"prepayid" : @"response.prepayid",
             @"sign" : @"response.sign",
             @"timestamp" : @"response.timestamp",
             };
}
@end
