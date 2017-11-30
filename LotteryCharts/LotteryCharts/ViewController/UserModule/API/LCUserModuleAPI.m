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
static NSString * const kMediaToken = @"public/getQiNiuTaken";
static NSString * const kUpdatePhoto = @"User/updateLogo.html";
static NSString * const kUpdateMessage = @"User/updateUserInfo.html";
static NSString * const kUserMessage = @"User/getMy.html";
static NSString * const kUserSign = @"User/sign.html";
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
@end
