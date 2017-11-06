//
//  PPSSUserHomeMessageModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSUserHomeMessageModel.h"

@implementation PPSSUserHomeMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"totalFee" : @"data.totalFee",
             @"shopFee" : @"data.shopFee",
             @"bankAccountNo" : @"data.bankAccountNo",
             @"userName" : @"data.userName",
             @"userPhone" : @"data.userPhone",
             @"userPower" : @"data.userPower"
             };
}
- (void)setShopFee:(NSString *)shopFee {
    _shopFee = KNullTransformMoney(shopFee);
}
- (void)setTotalFee:(NSString *)totalFee {
    _totalFee = KNullTransformMoney(totalFee);
}
- (void)setBankAccountNo:(NSString *)bankAccountNo {
    _bankAccountNo = KNullTransformMoney(bankAccountNo);
}
@end
