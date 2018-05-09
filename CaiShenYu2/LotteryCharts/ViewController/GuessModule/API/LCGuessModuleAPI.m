//
//  LCGuessModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessModuleAPI.h"
#import "LSKBaseResponseModel.h"
#import "LCGuessMainListModel.h"
#import "LCGuessMainMoreModel.h"
#import "LCGuessDetailModel.h"
#import "LCGuessReplyListModel.h"
#import "LCReplySuccessModel.h"

static NSString * const kPushGuessApi = @"quiz/add.html";
static NSString * const kGuessMainApi = @"Direct/getQuizList.html";
static NSString * const kGuessMainMoreApi = @"Direct/getQuiz.html";
static NSString * const kGuessDetailApi = @"Quiz/challengeKill.html";
static NSString * const kGuessReplyApi = @"quiz/reply.html";
static NSString * const kReplyGuessListApi = @"quiz/commentReplyList.html";

static NSString * const kGuessReplyListApi = @"Quiz/challengeReply.html";
static NSString * const kBetGuessApi = @"Quiz/challengeData.html";
static NSString * const kGuessListApi = @"Direct/getOldQuizList.html";

@implementation LCGuessModuleAPI

+ (LSKParamterEntity *)pushGuessEvent:(NSInteger)type content:(NSString *)content answer:(NSString *)answer money:(NSString *)money number:(NSString *)number title:(NSString *)title {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPushGuessApi;
    entity.responseObject = [LSKBaseResponseModel class];
    entity.params = @{@"quiz_type":@(type),@"quiz_content":content,@"quiz_answer":answer,@"quiz_money":money,@"quiz_number":number,@"quiz_title":title,@"token":kUserMessageManager.token};
    return entity;
}
+ (LSKParamterEntity *)guessMainList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGuessMainApi;
    entity.params = @{@"p":@(page)};
    entity.responseObject = [LCGuessMainListModel class];
    return entity;
}

+ (LSKParamterEntity *)guessOldList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGuessListApi;
    entity.params = @{@"p":@(page)};
    entity.responseObject = [LCGuessMainListModel class];
    return entity;
}

+ (LSKParamterEntity *)guessMainMoreList:(NSInteger)page period_id:(NSString *)period_id {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGuessMainMoreApi;
    entity.params = @{@"p":@(page),@"period_id":period_id};
    entity.responseObject = [LCGuessMainMoreModel class];
    return entity;
}

+ (LSKParamterEntity *)getGuessDetail:(NSString *)quiz_id {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGuessDetailApi;
    entity.params = @{@"token":kUserMessageManager.token,@"quiz_id":quiz_id};
    entity.responseObject = [LCGuessDetailModel class];
    return entity;
}

+ (LSKParamterEntity *)sendGuessComment:(NSString *)quiz_id target_id:(NSString *)target_id target_type:(NSInteger)target_type message:(NSString *)message {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGuessReplyApi;
    entity.params = @{@"target_type":@(target_type),@"target_id":target_id,@"token":kUserMessageManager.token,@"quiz_id":quiz_id,@"message":message};
    entity.responseObject = [LCReplySuccessModel class];
    return entity;
}

+ (LSKParamterEntity *)getReplyGuessList:(NSInteger)page commentId:(NSString *)commentId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kReplyGuessListApi;
    entity.params = @{@"page_size":@(PAGE_SIZE_NUMBER),@"token":kUserMessageManager.token,@"comment_id":commentId,@"p":@(page)};
    entity.responseObject = [LCGuessReplyListModel class];
    return entity;
}

+ (LSKParamterEntity *)getGuessDetail:(NSString *)quiz_id page:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    if (page == 0) {
        return [[self class] getGuessDetail:quiz_id];
    }else {
        entity.requestApi = kGuessReplyListApi;
        entity.params = @{@"token":kUserMessageManager.token,@"quiz_id":quiz_id,@"p":@(page- 1)};
        entity.responseObject = [LCGuessReplyListModel class];
    }
    return entity;
}

+ (LSKParamterEntity *)betGuessMessage:(NSString *)quiz_id period_id:(NSString *)period_id betting_num:(NSString *)betting_num {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kBetGuessApi;
    entity.params = @{@"token":kUserMessageManager.token,@"quiz_id":quiz_id,@"betting_num":betting_num,@"period_id":period_id};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
@end
