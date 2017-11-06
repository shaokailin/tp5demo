//
//  PPSSCashierApi.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PPSSCashierApi : NSObject
//获取用户的信息 通过 token
+ (LSKParamterEntity *)getUserMessageRequest;

/**
 获取会员列表

 @param page 页码
 @param searchTest 搜索内容
 @return 参数
 */
+ (LSKParamterEntity *)getMemberListWithPage:(NSInteger)page searchText:(NSString *)searchTest;

/**
 获取会员详情列表

 @param userId 会员id
 @return 参数
 */
+ (LSKParamterEntity *)getMemberDetail:(NSString *)userId;

/**
 申请收银卡物料

 @return 参数
 */
+ (LSKParamterEntity *)applyShopCard;

/**
 查询总收支

 @param timestamp 时间戳
 @param shopId 店铺id
 @return 参数
 */
+ (LSKParamterEntity *)getAllIncomeWithTimestamp:(NSInteger)timestamp shopId:(NSString *)shopId;

/**
 商户收款扫码用户

 @param total 总额
 @param realPay 不参与金额
 @param qcode 二维
 @return 参数
 */
+ (LSKParamterEntity *)payMoneyEventWithTotal:(NSString *)total realPay:(NSString *)realPay qcode:(NSString *)qcode;

/**
 公告列表

 @param page 页数
 @return 参数
 */
+ (LSKParamterEntity *)getNoticeList:(NSInteger)page;

/**
 获取活动列表

 @param page 页数
 @param state 活动状态：1全部、2进行中、3未开始、4已完成
 @param needPromotion 是否查询可参加的活动:1是2否
 @return 参数
 */
+ (LSKParamterEntity *)getActivityList:(NSInteger)page state:(NSInteger)state needPromotion:(NSInteger)needPromotion;

/**
 编辑活动

 @param editType 类型
 @param model 对象
 @return 参数
 */
+ (LSKParamterEntity *)editActivityWithType:(NSInteger)editType model:(NSDictionary *)model;
@end
