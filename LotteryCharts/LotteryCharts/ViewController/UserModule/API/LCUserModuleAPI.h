//
//  LCUserModuleAPI.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUserModuleAPI : NSObject
+ (LSKParamterEntity *)getMediaToken;
+ (LSKParamterEntity *)updateUserPhoto:(NSString *)url;

+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSInteger)birthday;

+ (LSKParamterEntity *)getUsermModuleMessage;

+ (LSKParamterEntity *)userSignEvent;

+ (LSKParamterEntity *)getUserAttention:(NSInteger)page;

+ (LSKParamterEntity *)getUserTeamList:(NSInteger)page type:(NSInteger)type;
+ (LSKParamterEntity *)getUserTeamCount;
+ (LSKParamterEntity *)getUserSignCount;

+ (LSKParamterEntity *)getTaskMessage;

+ (LSKParamterEntity *)glodExchangeSilver:(NSInteger)money;

+ (LSKParamterEntity *)attentionUser:(NSString *)userId;
+ (LSKParamterEntity *)getOtherAttention:(NSInteger)page userId:(NSString *)userId;
+ (LSKParamterEntity *)spaceMessageDataWith:(NSString *)userId page:(NSInteger)page showType:(NSInteger)showType;
@end
