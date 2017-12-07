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
static NSString * const kPushGuessApi = @"quiz/add.html";
static NSString * const kGuessMainApi = @"Direct/getQuizList.html";
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
@end
