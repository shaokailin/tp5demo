//
//  PPSSCashiersListModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashiersListModel.h"
#import "PPSSCashierModel.h"
@implementation PPSSCashiersListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [PPSSCashierModel class],
             };
}
@end
