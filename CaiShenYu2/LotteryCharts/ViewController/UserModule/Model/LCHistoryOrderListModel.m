//
//  LCHistoryOrderListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryOrderListModel.h"

@implementation LCHistoryOrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"response" : [LCHistoryOrderModel class]
              };
}

@end
@implementation LCHistoryOrderModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    NSNumber *paytime = dic[@"pay_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    BOOL isPayTime = ([paytime isKindOfClass:[NSNumber class]] || [paytime isKindOfClass:[NSString class]]);
    if (isStartTime) {
//        NSString *formar = @"yyyy-MM-dd HH:mm:ss";
        BOOL result = NO;;
        if (isStartTime) {
            _create_time = [LSKPublicMethodUtil timeStr:[createTime integerValue]];
            result = YES;
        }
        if (isPayTime) {
            _pay_time = [LSKPublicMethodUtil timeStr:[paytime integerValue]];
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
