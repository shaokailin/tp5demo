//
//  LCAttentionListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCAttentionListModel.h"

@implementation LCAttentionListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCAttentionModel class],
             };
}
@end
@implementation LCAttentionModel

@end
