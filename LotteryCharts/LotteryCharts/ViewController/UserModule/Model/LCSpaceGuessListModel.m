//
//  LCSpaceGuessListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceGuessListModel.h"

@implementation LCSpaceGuessListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCGuessModel class],
             };
}
@end
