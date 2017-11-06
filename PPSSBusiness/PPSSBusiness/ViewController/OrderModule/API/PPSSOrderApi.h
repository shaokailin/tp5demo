//
//  PPSSOrderApi.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

@interface PPSSOrderApi : NSObject

/**
 获取商户门店

 @return 参数
 */
+ (LSKParamterEntity *)getShopList;

/**
 获取流水列表

 @param time 选择查看的时间
 @param page 页数
 @param shopId 查看某个店面的流水
 @param payType 付款方式
 @param payStatus 付款状态
 @param content 搜索内容
 @return 参数
 */
+ (LSKParamterEntity *)getOrderListWithTime:(NSInteger)time page:(NSInteger)page shopId:(NSString *)shopId payType:(NSInteger)payType payStatus:(NSInteger)payStatus content:(NSString *)content;

/**
 获取流水详情

 @param orderId 流水号
 @return 参数
 */
+ (LSKParamterEntity *)getOrderDetailWithId:(NSString *)orderId;
@end
