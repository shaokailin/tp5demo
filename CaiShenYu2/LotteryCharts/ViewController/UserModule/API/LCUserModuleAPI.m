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
#import "LCSpaceSendRecordListModel.h"
#import "LCSpaceSendRankingListModel.h"
#import "LCSpaceSendRecrdMoreListModel.h"
#import "LCHistoryOrderListModel.h"
#import "LCWithdrawRecordListModel.h"
#import "LCCantactListModel.h"
#import "LCUserSignMessageModel.h"
#import "LCOrderHistoryGuessModel.h"
#import "UserListModel.h"
#import "LCUserMessageListModel.h"
#import "LCUserSettingModel.h"
static NSString * const kMediaToken = @"public/getQiNiuTaken";
static NSString * const kUpdatePhoto = @"User/updateLogo.html";
static NSString * const kUpdateBgPhoto = @"User/updateBglogo.html";

static NSString * const kUpdateMessage = @"User/updateUserInfo.html";
static NSString * const kUserMessage = @"User/getMy.html";
static NSString * const kUserSign = @"User/sign.html";
static NSString * const kUserSignMessage = @"User/getSignRecord.html";
static NSString * const kAttentionList = @"User/myFollow.html";
static NSString * const kContactList = @"Direct/getContact";

static NSString * const kTeamList = @"User/myTeam.html";
static NSString * const kSignList = @"User/myTeamSign.html";
static NSString * const kTeamLineCount = @"User/getOnlineTeamCount.html";
static NSString * const kSignCount = @"User/getMyTeamSignCount.html";
static NSString * const kTaskMessage = @"User/myTask.html";
static NSString * const kShareSuccess = @"user/shareSuccess.html";
static NSString * const kExchangeSilver = @"User/jinChangeYin.html";
static NSString * const kExchangeRate = @"direct/getUserJinBiLi";
static NSString * const kMoneyRate = @"public/serverCharge.html";

static NSString * const kUserAttenttion = @"Mch/follow.html";
static NSString * const kUserUnAttenttion = @"Mch/unFollow.html";
//被关注
static NSString * const kOtherAttentionList = @"Mch/userBeiFollow.html";
static NSString * const kUserFansList = @"user/fans.html";

static NSString * const kUserAttenttionList = @"Mch/follow.html";
static NSString * const kSpacePostFirstList = @"Mch/getMchPost.html";
static NSString * const kSpacePostList = @"Mch/mchPostList.html";
static NSString * const kSpaceGuessList = @"Mch/getQuizList.html";
static NSString * const kSendRecordFirstList = @"Mch/getSmoneyLog.html";
static NSString * const kSendRecordList = @"Mch/getSmoneyLogNext.html";
static NSString * const kSendRankingList = @"Mch/getSmoneyPaiHang.html";

static NSString * const kHisttoryOrderList = @"User/getMyPostLog.html";

static NSString * const kWithdrawMoney = @"User/tiQian.html";
static NSString * const kWithdrawMoneyList = @"User/getTiQianLog.html";
static NSString * const kRechargeMoneyList = @"User/getPayLog.html";
static NSString * const KchallengeList = @"quiz/challengeList";
static NSString * const kReportUser = @"user/compliant.html";
static NSString * const kMessageList = @"message/messagelist.html";
static NSString * const kMessageCount = @"message/unreadCount.html";
static NSString * const kMessageShow = @"message/read.html";

static NSString * const kMessageSetting = @"message/getMessageSwitch.html";
static NSString * const kMessageSettingChange = @"message/setMessageSwitch.html";
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
+ (LSKParamterEntity *)updateBgImage:(NSString *)url {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpdateBgPhoto;
    entity.params = @{@"token":kUserMessageManager.token,@"bglogo":url};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSInteger)birthday machid:(NSString *)machid {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpdateMessage;
    
    if (machid) {
        entity.params = @{@"token":kUserMessageManager.token,@"logo":photoUrl,@"sex":sex,@"nickname":nickname,@"birthday":@(birthday), @"mchild":machid};
    } else {
        entity.params = @{@"token":kUserMessageManager.token,@"logo":photoUrl,@"sex":sex,@"nickname":nickname,@"birthday":@(birthday)};
    }
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
+ (LSKParamterEntity *)userSignMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserSignMessage;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCUserSignMessageModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserAttention:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAttentionList;
    entity.params = @{@"token":kUserMessageManager.token,@"p":@(page)};
    entity.responseObject = [LCAttentionListModel class];
    return entity;
}
+ (LSKParamterEntity *)getContactList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kContactList;
    //    entity.params = @{@"token":kUserMessageManager.token,@"p":@(page)};
    entity.responseObject = [LCCantactListModel class];
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

+ (LSKParamterEntity *)sendShareSuccess {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kShareSuccess;
    entity.params = @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)glodExchangeSilver:(NSInteger)money {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kExchangeSilver;
    entity.params = @{@"token":kUserMessageManager.token,@"jinbinum":@(money)};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getExchangeRate {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kExchangeRate;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getMoneyRate {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMoneyRate;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)attentionUser:(NSString *)userId isCare:(BOOL)isCare {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    if (isCare) {
        entity.requestApi = kUserUnAttenttion;
    }else {
        entity.requestApi = kUserAttenttion;
    }
    entity.params = @{@"token":kUserMessageManager.token,@"mchid":userId};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)zanPost:(NSString *)post {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = @"post/thumbsup.html";
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":post};
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

+ (LSKParamterEntity *)getFansList:(NSInteger)page userId:(NSString *)userId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUserFansList;
    if (KJudgeIsNullData(userId)) {
        entity.params = @{@"user_id":userId,@"p":@(page),@"token":kUserMessageManager.token};
    }else {
        entity.params = @{@"p":@(page),@"token":kUserMessageManager.token};
    }
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
            entity.responseObject = [LCSpaceSendRecordListModel class];
        }else {
            entity.requestApi = kSendRecordList;
            entity.responseObject = [LCSpaceSendRecrdMoreListModel class];
        }
    }else {
        entity.requestApi = kSendRankingList;
        entity.responseObject = [LCSpaceSendRankingListModel class];
    }
    entity.params = @{@"mchid":userId,@"p":@(page),@"token":kUserMessageManager.token};
    return entity;
}

+ (LSKParamterEntity *)getHisttoryOrderWith:(NSString *)searchId page:(NSInteger)page showType:(NSInteger)showType {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHisttoryOrderList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(page),@"p",kUserMessageManager.token,@"token",@(showType + 1),@"post_type", nil];
    if (KJudgeIsNullData(searchId)) {
        [params setObject:searchId forKey:@"id"];
    }
    entity.params = params;
    if (showType == 1) {
        entity.responseObject = [LCOrderHistoryGuessModel class];
    }else {
        entity.responseObject = [LCHistoryOrderListModel class];
    }
    
    return entity;
}
+ (LSKParamterEntity *)widthdrawMoney:(NSString *)money {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kWithdrawMoney;
    entity.params = @{@"jinbinum":money,@"token":kUserMessageManager.token};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)widthdrawRecordList:(NSInteger)page month:(NSInteger)month year:(NSInteger)year {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kWithdrawMoneyList;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(page),@"p",kUserMessageManager.token,@"token", nil];
    if (month != -1) {
        [param setObject:@(month) forKey:@"month"];
    }
    if (year != -1) {
        [param setObject:@(year) forKey:@"year"];
    }
    entity.params = param;
    entity.responseObject = [LCWithdrawRecordListModel class];
    return entity;
}
+ (LSKParamterEntity *)rechargeRecordList:(NSInteger)page month:(NSInteger)month year:(NSInteger)year {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kRechargeMoneyList;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(page),@"p",kUserMessageManager.token,@"token", nil];
    if (month != -1) {
        [param setObject:@(month) forKey:@"month"];
    }
    if (year != -1) {
        [param setObject:@(year) forKey:@"year"];
    }
    entity.params = param;
    entity.responseObject = [LCWithdrawRecordListModel class];
    return entity;
}

+ (LSKParamterEntity *)getlistUserModel:(NSInteger)page userId:(NSString *)userId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = KchallengeList;
    entity.params = @{@"quiz_id":userId,@"p":@(page),@"token":kUserMessageManager.token};
    entity.responseObject = [UserListModel class];
    return entity;
}

+ (LSKParamterEntity *)reportOtherUser:(NSString *)uesrId content:(NSString *)content postId:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kReportUser;
    entity.requestType = 1;
    entity.params =  @{@"complaint_from_userid":kUserMessageManager.userId,@"complaint_to_userid":uesrId,@"content":content,@"post_id":postId,@"token":kUserMessageManager.token};;
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getUserAndSystemNoticeList:(NSInteger)page type:(NSInteger)type {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMessageList;
    entity.params = @{@"page_size":@(PAGE_SIZE_NUMBER),@"p":@(page),@"type":@(type),@"token":kUserMessageManager.token};
    entity.responseObject = [LCUserMessageListModel class];
    return entity;
}

+ (LSKParamterEntity *)getNoticeCount {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMessageCount;
    entity.requestType = 1;
    entity.params =  @{@"token":kUserMessageManager.token};;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)changeNoticeShow:(NSString *)msgId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMessageShow;
    entity.requestType = 1;
    entity.params =  @{@"msg_id":msgId,@"token":kUserMessageManager.token};;
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getNoticeSetting {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMessageSetting;
    entity.requestType = 1;
    entity.params =  @{@"token":kUserMessageManager.token};
    entity.responseObject = [LCUserSettingModel class];
    return entity;
}
+ (LSKParamterEntity *)changeNoticeSetting:(BOOL)comment focus:(BOOL)focus reward:(BOOL)reward system:(BOOL)system {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kMessageSettingChange;
    entity.requestType = 1;
    entity.params =  @{@"token":kUserMessageManager.token,@"comment_reply":@(comment),@"focus":@(focus),@"reward":@(reward),@"system":@(system)};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
@end
