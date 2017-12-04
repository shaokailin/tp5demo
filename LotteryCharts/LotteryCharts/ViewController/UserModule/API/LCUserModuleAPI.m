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
#import "LCSpacePostListModel.h"
#import "LCSpacePostModel.h"
#import "LCSpaceGuessListModel.h"
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

static NSString * const kUserAttenttion = @"Mch/follow.html";
//被关注
static NSString * const kOtherAttentionList = @"Mch/userBeiFollow.html";
static NSString * const kUserAttenttionList = @"Mch/follow.html";
static NSString * const kSpacePostFirstList = @"Mch/getMchPost.html";
static NSString * const kSpacePostList = @"Mch/mchPostList.html";
static NSString * const kSpaceGuessList = @"Mch/getQuizList.html";
static NSString * const kSendRecordFirstList = @"Mch/getSmoneyLog.html";
static NSString * const kSendRecordList = @"Mch/getSmoneyLogNext.html";
static NSString * const kSendRankingList = @"Mch/getSmoneyPaiHang.html";
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

+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSInteger)birthday {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpdateMessage;
    
    entity.params = @{@"token":kUserMessageManager.token,@"logo":photoUrl,@"sex":sex,@"nickname":nickname,@"birthday":@(birthday)};
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
+ (LSKParamterEntity *)attentionUser:(NSString *)userId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserAttenttion;
    entity.params = @{@"token":kUserMessageManager.token,@"mchid":userId};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getOtherAttention:(NSInteger)page userId:(NSString *)userId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kOtherAttentionList;
    entity.params = @{@"mchid":userId,@"p":@(page),@"token":kUserMessageManager.token};
    entity.responseObject = [LCAttentionListModel class];
    return entity;
}
+ (LSKParamterEntity *)spaceMessageDataWith:(NSString *)userId page:(NSInteger)page showType:(NSInteger)showType {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    if (showType == 0) {
        if (page == 0) {
            entity.requestApi = kSpacePostFirstList;
            entity.responseObject = [LCSpacePostListModel class];
        }else {
            entity.requestApi = kSpacePostList;
            entity.responseObject = [LCSpacePostModel class];
        }
    }else if (showType == 1) {
        entity.requestApi = kSpaceGuessList;
        entity.responseObject = [LCSpaceGuessListModel class];
    }else if (showType == 2) {
        if (page == 0) {
            entity.requestApi = kSendRecordFirstList;
            entity.responseObject = [LCSpacePostListModel class];
        }else {
            entity.requestApi = kSendRecordList;
            entity.responseObject = [LCSpacePostModel class];
        }
    }else {
        entity.requestApi = kSendRankingList;
        entity.responseObject = [LCSpaceGuessListModel class];
    }
    entity.params = @{@"mchid":userId,@"p":@(page),@"token":kUserMessageManager.token};
    return entity;
}
@end
