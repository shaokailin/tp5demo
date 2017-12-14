//
//  LCPostDetailMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailMessageModel.h"

@implementation LCPostDetailMessageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCHomePostModel class],
             };
}
@end
