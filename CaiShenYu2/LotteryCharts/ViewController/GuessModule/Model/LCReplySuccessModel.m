//
//  LCReplySuccessModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCReplySuccessModel.h"

@implementation LCReplySuccessModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCPostReplyModel class],
             };
    
}
@end
