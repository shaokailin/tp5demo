//
//  PPSSActivityModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSActivityModel : NSObject
@property (nonatomic, copy) NSString *promotionId;//活动id
@property (nonatomic, copy) NSString *shopId;//商铺id
@property (nonatomic, copy) NSString *shopName;//商铺名称
@property (nonatomic, copy) NSString *promotionType;//活动类型id = actid
@property (nonatomic, copy) NSString *promotionPercent;//百分比进度
@property (nonatomic, copy) NSString *promotionIntensity;//活动力度
@property (nonatomic, copy) NSString *promotionTitle;//标题
@property (nonatomic, copy) NSString *promotionBody;//活动内容
@property (nonatomic, copy) NSString *promotionUsers;//参与人数
@property (nonatomic, copy) NSString *promotionPrice;//总营业额
@property (nonatomic, copy) NSString *promotionMoney;//发放余额
@property (nonatomic, copy) NSString *promotionStartTime;//开始时间
@property (nonatomic, copy) NSString *promotionEndTime;//结束时间
@property (nonatomic, strong) NSArray *promotionTime;//时间段
@property (nonatomic, copy) NSString *periodOfValidity;//劵有效期
@property (nonatomic, copy) NSString *setPoint;//集点兑换值
@property (nonatomic, copy) NSString *pointChangeBalance;//集点兑换值可兑换得到的余额
@property (nonatomic, assign) NSInteger closeOrOpen;//是否开启
@property (nonatomic, copy) NSString *promotionLimitTime;//有效期
@end
