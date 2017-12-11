//
//  LCHomeModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeModuleAPI.h"
#import "LCHomeHeaderMessageModel.h"
#import "LCBaseResponseModel.h"
#import "LCHomeHotListModel.h"
#import "LCRankingRenListModel.h"
#import "LCRankingVipListModel.h"
static NSString * kPushPostApi = @"post/add.html";
static NSString * kOnlineAllApi = @"Direct/getOnlineNum.html";
static NSString * kHomeHotPostApi = @"Index/hotpost.html";
static NSString * kHomeHeaderApi = @"Index/index.html";
static NSString * kVipPostApi = @"Index/vipPost.html";
static NSString * kRenPostApi = @"Index/renPost.html";
static NSString * kPullPostApi = @"Index/pullPost.html";
static NSString * kRewardPostApi = @"Index/rewardPost.html";
@implementation LCHomeModuleAPI
+ (LSKParamterEntity *)pushPostEvent:(NSString *)title content:(NSString *)content media:(NSString *)media type:(NSInteger)type money:(NSString *)money vipMoney:(NSString *)vipMoney {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPushPostApi;
    entity.responseObject = [LSKBaseResponseModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:title,@"post_title",content,@"post_content",media,@"post_upload",@(type),@"post_type",kUserMessageManager.token,@"token", nil];
    if (type == 1) {
        [param setObject:money forKey:@"post_money"];
    }
    if (KJudgeIsNullData(vipMoney)) {
        [param setObject:vipMoney forKey:@"post_vipmoney"];
    }
    entity.params = param;
    return entity;
}

+ (LSKParamterEntity *)getOnLineAll {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kOnlineAllApi;
    entity.requestType = HTTPRequestType_GET;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getHotPostList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHomeHotPostApi;
    entity.params = @{@"p":@(page)};
    entity.responseObject = [LCHomeHotListModel class];
    return entity;
}
+ (LSKParamterEntity *)getHomeHeaderMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHomeHeaderApi;
    entity.responseObject = [LCHomeHeaderMessageModel class];
    return entity;
}

+ (LSKParamterEntity *)getPostRanking:(NSInteger)page type:(NSInteger)type {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.params = @{@"p":@(page)};
    if (type != 1) {
        if (type == 0) {
            entity.requestApi = kVipPostApi;
        }else if (type == 2){
            entity.requestApi = kPullPostApi;
        }else {
            entity.requestApi = kRewardPostApi;
        }
        entity.responseObject = [LCRankingVipListModel class];
    }else {
        entity.requestApi =kRenPostApi;
        entity.responseObject = [LCRankingRenListModel class];
    }
    return entity;
}
@end
