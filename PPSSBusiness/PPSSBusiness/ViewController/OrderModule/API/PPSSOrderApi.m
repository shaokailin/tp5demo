//
//  PPSSOrderApi.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderApi.h"
#import "PPSSShopListModel.h"
#import "PPSSOrderListModel.h"
#import "PPSSOrderDetailModel.h"
//获取商铺列表
static NSString * const kUserShopList = @"appUser/findShopsByToken";
//获取流水列表
static NSString * const kUserOrderList = @"appPay/findIncomeList";
//获取流水详情
static NSString * const kOrderDetail = @"appPay/findIncomeOrderNo";
@implementation PPSSOrderApi
+ (LSKParamterEntity *)getShopList {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserShopList;
    entity.responseObject = [PPSSShopListModel class];
    [entity.params setValue:KUserMessageManager.userToken forKey:@"token"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    return entity;
}

+ (LSKParamterEntity *)getOrderListWithTime:(NSInteger)time page:(NSInteger)page shopId:(NSString *)shopId payType:(NSInteger)payType payStatus:(NSInteger)payStatus content:(NSString *)content {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserOrderList;
    entity.responseObject = [PPSSOrderListModel class];
    [entity.params setValue:@(time) forKey:@"incomeDay"];
    [entity.params setValue:@(page + 1) forKey:@"pageNum"];
    [entity.params setValue:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    [entity.params setValue:KUserMessageManager.userToken forKey:@"token"];
    if (KJudgeIsNullData(shopId)) {
        [entity.params setValue:shopId forKey:@"shopId"];
    }
    if (payType >= 0) {
        [entity.params setValue:@(payType) forKey:@"payType"];
    }
    if (payStatus >= 0) {
        [entity.params setValue:@(payStatus) forKey:@"payState"];
    }
    if (KJudgeIsNullData(content)) {
        [entity.params setValue:content forKey:@"content"];
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    return entity;
}

+ (LSKParamterEntity *)getOrderDetailWithId:(NSString *)orderId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kOrderDetail;
    entity.responseObject = [PPSSOrderDetailModel class];
    [entity.params setValue:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setValue:KNullTransformString(orderId) forKey:@"orderNo"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    return entity;
}
@end
