//
//  PPSSCashierModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierModel.h"

@implementation PPSSCashierModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name" : @"userName",
             @"phone" : @"userPhone",
             };
}
@end
