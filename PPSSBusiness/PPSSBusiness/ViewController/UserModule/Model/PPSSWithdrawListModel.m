//
//  PPSSWithdrawListModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWithdrawListModel.h"
@implementation PPSSWithdrawModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"withdrawId" : @"id",
             };
}
- (void)setAmount:(NSString *)amount {
    _amount = KNullTransformMoney(amount);
}
@end
@implementation PPSSWithdrawListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [PPSSWithdrawModel class],
             };
}
@end
