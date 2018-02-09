//
//  LCWeiPayOrderModel.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/2/9.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCWeiPayOrderModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *timestamp;
@end
