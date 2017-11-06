//
//  PPSSUserApi.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSUserApi.h"
#import "PPSSWithdrawListModel.h"
#import "PPSSUserHomeMessageModel.h"
#import "PPSSCashiersListModel.h"
#import "PPSSCashierExitResultModel.h"
//提现列表
static NSString * const kWithdrawList = @"appPay/findShopWithdraw";
//提现申请
static NSString * const kWithdrawApply = @"appPay/applyShopWithdraw";
//获取个人中心数据
static NSString * const kUserMessage = @"appShop/findShop";
//收银员列表
static NSString * const kCashiersList = @"appShop/findShopUser";
//编辑收银员
static NSString * const kEditCashier = @"appShop/editShopUser";
//  商户操作人员给会员添加标签
static NSString * const kEditMemberRemark = @"appUser/editMemberById";
// 保存商户投诉建议
static NSString * const kUserComplaint = @"appShop/editShopComplaint";
@implementation PPSSUserApi
+ (LSKParamterEntity *)withdrawApplyEvent:(NSString *)money {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    entity.requestApi = kWithdrawApply;
    [entity.params setObject:money forKey:@"amount"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getWithdrawListWithPage:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(page + 1) forKey:@"pageNum"];
    [entity.params setObject:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kWithdrawList;
    entity.responseObject = [PPSSWithdrawListModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserHomeMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kUserMessage;
    entity.responseObject = [PPSSUserHomeMessageModel class];
    return entity;
}

+ (LSKParamterEntity *)getCashierList:(NSInteger)page searchText:(NSString *)searchTest  {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(page + 1) forKey:@"pageNum"];
    [entity.params setObject:@(PAGE_SIZE_NUMBER) forKey:@"pageSize"];
    if (KJudgeIsNullData(searchTest)) {
        [entity.params setObject:searchTest forKey:@"content"];
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kCashiersList;
    entity.responseObject = [PPSSCashiersListModel class];
    return entity;
}


+ (LSKParamterEntity *)editCashierWithType:(NSInteger)editType model:(NSDictionary *)modelDict {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    [entity.params setObject:@(editType) forKey:@"handType"];
    [entity.params addEntriesFromDictionary:modelDict];
    NSString *pwd = [modelDict objectForKey:@"password"];
    if (KJudgeIsNullData(pwd)) {
        [entity.params setObject:[NSString MD5:NSStringFormat(@"%@hsplan",KNullTransformString(pwd))] forKey:@"password"];
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.requestApi = kEditCashier;
    entity.responseObject = [PPSSCashierExitResultModel class];
    return entity;
}
+ (LSKParamterEntity *)editRemarkTextWithUserId:(NSString *)userId remark:(NSString *)remark type:(NSInteger)type {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
    if (KJudgeIsNullData(userId)) {
        [entity.params setObject:userId forKey:@"userId"];
        [entity.params setObject:remark forKey:@"remark"];
        entity.requestApi = kEditMemberRemark;
    }else {
        [entity.params setObject:@(type) forKey:@"complaintType"];
        [entity.params setObject:remark forKey:@"content"];
        entity.requestApi = kUserComplaint;
    }
    [entity initializeSignWithParams:KUserMessageManager.userToken, nil];
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
@end
