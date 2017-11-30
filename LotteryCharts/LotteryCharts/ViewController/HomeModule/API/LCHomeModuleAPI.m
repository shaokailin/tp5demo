//
//  LCHomeModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeModuleAPI.h"
#import "LSKBaseResponseModel.h"
static NSString * kPushPostApi = @"post/add.html";
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
@end
