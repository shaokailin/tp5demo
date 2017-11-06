//
//  PPSSWithdrawListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSWithdrawModel : NSObject
@property (nonatomic, copy) NSString *withdrawId;//提现id
@property (nonatomic, copy) NSString *time;//提现时间
@property (nonatomic, copy) NSString *state;//提现状态：0-待审核，1-审核成功，2-审核失败
@property (nonatomic, copy) NSString *amount;//提现金额
@end
@interface PPSSWithdrawListModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *profitFee;//消费分润
@property (nonatomic, copy) NSString *shopFee;//商户余额
@property (nonatomic, strong) NSArray *data;
@end
