//
//  LCGuessReplyListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessReplyListModel.h"

@implementation LCGuessReplyListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCPostReplyModel class],
             };
    
}

@end
