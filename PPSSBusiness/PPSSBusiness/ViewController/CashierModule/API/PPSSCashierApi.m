//
//  PPSSCashierApi.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierApi.h"
#import "PPSSLoginModel.h"
#import "PPSSMemberListModel.h"
#import "PPSSMemberDetailModel.h"
#import "PPSSIncomeModel.h"
#import "PPSSNoticeListModel.h"
#import "PPSSActivityListModel.h"
#import "PPSSActivityEditResultModel.h"
//获取商户的信息
static NSString * const kUserMessageByToken = @"appUser/findUserByToken";
//获取会员列表
static NSString * const kMemberList = @"appUser/findMembersByToken";
//获取会员详情
static NSString * const kMemberDetail = @"appUser/findMemberById";
//申请收银卡物料
static NSString * const kApplyShopCard = @"appPay/applyDecca";
//获取总收入
static NSString * const kAllIncome = @"appPay/findIncomeDay";
//商户收款扫码用户
static NSString * const kPayMoney = @"appPay/paySweep";
//公告列表
static NSString * const kNoticeList = @"appShop/findShopMessage";
//获取活动列表
static NSString * const kActivityList = @"appShop/findShopPromotion";
//编辑活动
static NSString * const kActivityEdit = @"appShop/editShopPromotion";
@implementation PPSSCashierApi
+ (LSKParamterEntity *)getUserMessageRequest {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.responseObject = [PPSSLoginModel class];
    entity.requestApi = kUserMessageByToken;
    return entity;
}
+ (LSKParamterEntity *)getMemberListWithPage:(NSInteger)page searchText:(NSString *)searchTest {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(page + 1) forKey:@"pageNum"];
    [entity.params setObject:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    if (KJudgeIsNullData(searchTest)) {
        [entity.params setObject:searchTest forKey:@"content"];
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kMemberList;
    entity.responseObject = [PPSSMemberListModel class];
    return entity;
}
+ (LSKParamterEntity *)getMemberDetail:(NSString *)userId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:KNullTransformString(userId) forKey:@"userId"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kMemberDetail;
    entity.responseObject = [PPSSMemberDetailModel class];
    return entity;
}
+ (LSKParamterEntity *)applyShopCard {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    entity.requestApi = kApplyShopCard;
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getAllIncomeWithTimestamp:(NSInteger)timestamp shopId:(NSString *)shopId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(timestamp) forKey:@"incomeDay"];
    if (KJudgeIsNullData(shopId)) {
        [entity.params setObject:shopId forKey:@"shopId"];
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kAllIncome;
    entity.responseObject = [PPSSIncomeModel class];
    return entity;
}

+ (LSKParamterEntity *)payMoneyEventWithTotal:(NSString *)total realPay:(NSString *)realPay qcode:(NSString *)qcode {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:total forKey:@"totalPay"];
    [entity.params setObject:KNullTransformString(realPay) forKey:@"realPay"];
    [entity.params setObject:qcode forKey:@"qcode"];
    [entity initializeSignWithParams:KUserMessageManager.userToken,total,realPay,qcode, nil];
    entity.requestApi = kPayMoney;
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getNoticeList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(page + 1) forKey:@"pageNum"];
    [entity.params setObject:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kNoticeList;
    entity.responseObject = [PPSSNoticeListModel class];
    return entity;
}

+ (LSKParamterEntity *)getActivityList:(NSInteger)page state:(NSInteger)state needPromotion:(NSInteger)needPromotion {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(page + 1) forKey:@"pageNum"];
    [entity.params setObject:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    [entity.params setObject:@(state) forKey:@"state"];
    [entity.params setObject:@(needPromotion) forKey:@"needPromotion"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kActivityList;
    entity.responseObject = [PPSSActivityListModel class];
    return entity;
}

+ (LSKParamterEntity *)editActivityWithType:(NSInteger)editType model:(NSDictionary *)model {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(editType) forKey:@"handType"];
    [entity.params addEntriesFromDictionary:model];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kActivityEdit;
    entity.responseObject = [PPSSActivityEditResultModel class];
    return entity;
}
@end
