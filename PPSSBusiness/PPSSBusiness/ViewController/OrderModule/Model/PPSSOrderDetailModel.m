//
//  PPSSOrderDetailModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderDetailModel.h"

@implementation PPSSOrderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"businessTime" : @"data.businessTime",
             @"businessType" : @"data.businessType",
             @"realPay" : @"data.realPay",
             @"totalPay" : @"data.totalPay",
             @"orderNo" : @"data.orderNo",
             @"shopName" : @"data.shopName",
             @"account" : @"data.account",
             @"payState" : @"data.payState",
             @"userName" : @"data.userName",
             };
}
- (void)setTotalPay:(NSString *)totalPay {
    _totalPay = NSStringFormat(@"￥%@",KNullTransformMoney(totalPay));
}
- (void)setRealPay:(NSString *)realPay {
    _realPay = KNullTransformMoney(realPay);
}
@end
