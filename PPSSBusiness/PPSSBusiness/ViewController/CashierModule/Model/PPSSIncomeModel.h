//
//  PPSSIncomeModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSIncomeModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *realFee;//净收入
@property (nonatomic, copy) NSString *totalFee;//总收入
@property (nonatomic, copy) NSString *promotionFee;//优惠金额
@property (nonatomic, copy) NSString *chargeFee;//手续费
@property (nonatomic, copy) NSString *aliFee;//支付宝支付金额
@property (nonatomic, copy) NSString *wxinFee;//微信支付金额
@property (nonatomic, copy) NSString *hsFee;//账户余额支付
@property (nonatomic, copy) NSString *bankFee;//银行入账
@end
