//
//  PPSSUserHomeMessageModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSUserHomeMessageModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *totalFee;//消费总额
@property (nonatomic, copy) NSString *shopFee;//商户余额
@property (nonatomic, copy) NSString *bankAccountNo;//银行待结算
@property (nonatomic, copy) NSString *userName;//用户名
@property (nonatomic, copy) NSString *userPhone;//电话
@property (nonatomic, copy) NSString *userPower;//权限
@end
