//
//  PPSSOrderListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSOrderModel :NSObject
@property (nonatomic, copy) NSString *businessTime;//交易时间
@property (nonatomic, copy) NSString *businessFee;//交易金额
@property (nonatomic, copy) NSString *businessType;//交易类型1平台余额2店铺余额3支付宝4微信
@property (nonatomic, copy) NSString *orderNo;//订单编号
@property (nonatomic, copy) NSString *payState;//支付状态1支付成功2支付失败
@property (nonatomic, copy) NSString *avatar;//用户头像
@property (nonatomic, copy) NSString *userName;//用户名
@end
@interface PPSSOrderListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@end
