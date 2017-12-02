//
//  LCUserModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserModuleAPI.h"
#import "LCBaseResponseModel.h"
#import "LCUserHomeMessageModel.h"
#import "LCAttentionListModel.h"
#import "LCTeamListModel.h"
#import "LCTeamCountModel.h"
#import "LCTaskModel.h"
static NSString * const kMediaToken = @"public/getQiNiuTaken";
static NSString * const kUpdatePhoto = @"User/updateLogo.html";
static NSString * const kUpdateMessage = @"User/updateUserInfo.html";
static NSString * const kUserMessage = @"User/getMy.html";
static NSString * const kUserSign = @"User/sign.html";
static NSString * const kAttentionList = @"User/myFollow.html";
static NSString * const kTeamList = @"User/myTeam.html";
static NSString * const kSignList = @"User/myTeamSign.html";
static NSString * const kTeamLineCount = @"User/getOnlineTeamCount.html";
static NSString * const kSignCount = @"User/getMyTeamSignCount.html";
static NSString * const kTaskMessage = @"User/myTask.html";
static NSString * const kExchangeSilver = @"User/jinChangeYin.html";
@implementation LCUserModuleAPI
+ (LSKParamterEntity *)getMediaToken {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMediaToken;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)updateUserPhoto:(NSString *)url {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpdatePhoto;
    entity.params = @{@"token":kUserMessageManager.token,@"logo":url};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSString *)birthday {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpdateMessage;
    entity.params = @{@"token":kUserMessageManager.token,@"logo":photoUrl,@"sex":sex,@"nickname":nickname,@"birthday":birthday};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getUsermModuleMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserMessage;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCUserHomeMessageModel class];
    return entity;
}
+ (LSKParamterEntity *)userSignEvent {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserSign;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserAttention:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAttentionList;
    entity.params = @{@"token":kUserMessageManager.token,@"p":@(page)};
    entity.responseObject = [LCAttentionListModel class];
    return entity;
}

+ (LSKParamterEntity *)getUserTeamList:(NSInteger)page type:(NSInteger)type {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    if (type == 0) {
        entity.requestApi = kTeamList;
    }else {
        entity.requestApi = kSignList;
    }
    entity.params = @{@"token":kUserMessageManager.token,@"p":@(page)};
    entity.responseObject = [LCTeamListModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserTeamCount {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kTeamLineCount;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCTeamCountModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserSignCount {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kSignCount;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getTaskMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kTaskMessage;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCTaskModel class];
    return entity;
}
+ (LSKParamterEntity *)glodExchangeSilver:(NSInteger)money {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kExchangeSilver;
    entity.params = @{@"token":kUserMessageManager.token,@"jinbinum":@(money)};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
@end
