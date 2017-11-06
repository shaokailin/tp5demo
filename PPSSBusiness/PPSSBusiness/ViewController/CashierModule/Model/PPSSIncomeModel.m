//
//  PPSSIncomeModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeModel.h"

@implementation PPSSIncomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"realFee" : @"data.realFee",
             @"totalFee" : @"data.totalFee",
             @"promotionFee" : @"data.promotionFee",
             @"chargeFee" : @"data.chargeFee",
             @"aliFee" : @"data.aliFee",
             @"wxinFee" : @"data.wxinFee",
             @"hsFee" : @"data.hsFee",
             @"bankFee" : @"data.bankFee",
             };
}
- (void)setTotalFee:(NSString *)totalFee {
    _totalFee = NSStringFormat(@"￥%@",KNullTransformMoney(totalFee));
}
- (void)setPromotionFee:(NSString *)promotionFee {
    _promotionFee = NSStringFormat(@"￥%@",KNullTransformMoney(promotionFee));
}
- (void)setChargeFee:(NSString *)chargeFee {
    _chargeFee = NSStringFormat(@"-￥%@",KNullTransformMoney(chargeFee));
}
- (void)setAliFee:(NSString *)aliFee {
    _aliFee = NSStringFormat(@"￥%@",KNullTransformMoney(aliFee));
}
- (void)setHsFee:(NSString *)hsFee {
    _hsFee = NSStringFormat(@"￥%@",KNullTransformMoney(hsFee));
}
- (void)setWxinFee:(NSString *)wxinFee {
    _wxinFee = NSStringFormat(@"￥%@",KNullTransformMoney(wxinFee));
}
- (void)setBankFee:(NSString *)bankFee {
    _bankFee = KNullTransformMoney(bankFee);
}
@end
