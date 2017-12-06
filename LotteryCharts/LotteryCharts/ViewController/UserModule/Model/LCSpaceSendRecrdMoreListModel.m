//
//  LCSpaceSendRecrdMoreListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceSendRecrdMoreListModel.h"

@implementation LCSpaceSendRecrdMoreListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"data" : [LCSendRecordModel class]
              };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"data" : @"response",
             };
}
@end
