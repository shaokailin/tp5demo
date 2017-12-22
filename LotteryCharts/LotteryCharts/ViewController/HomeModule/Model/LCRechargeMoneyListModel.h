//
//  LCRechargeMoneyListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCRechargeMoneyModel : NSObject
@property (nonatomic, copy) NSString *payId;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *paymoney;
@end
@interface LCRechargeMoneyListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
