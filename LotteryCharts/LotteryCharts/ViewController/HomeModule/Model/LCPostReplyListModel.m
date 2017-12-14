//
//  LCPostReplyListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostReplyListModel.h"

@implementation LCPostReplyListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCPostReplyModel class],
             };
}
@end
