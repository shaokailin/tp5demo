//
//  LCCantactListModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCCantactListModel.h"

@implementation LCCantactListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"response" : [LCCantactModel class]
              };
}
@end
@implementation LCCantactModel

@end
