//
//  PPSSOrderDetailModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSOrderDetailModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *businessTime;//交易时间
@property (nonatomic, copy) NSString *shopName;//收款门店
@property (nonatomic, copy) NSString *businessType;//实付金额类型
@property (nonatomic, copy) NSString *orderNo;//订单编号
@property (nonatomic, copy) NSString *realPay;//实付金额
@property (nonatomic, copy) NSString *totalPay;//订单总金额
@property (nonatomic, copy) NSString *payState;//支付状态
@property (nonatomic, copy) NSString *userName;//用户昵称
@property (nonatomic, strong) NSArray *account;
@end
