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
+ (LSKParamterEntity *)updateBgImage:(NSString *)url;
+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSInteger)birthday machid:(NSString *)machid;

+ (LSKParamterEntity *)getUsermModuleMessage;

+ (LSKParamterEntity *)userSignEvent;
+ (LSKParamterEntity *)userSignMessage;

+ (LSKParamterEntity *)getUserAttention:(NSInteger)page;
+ (LSKParamterEntity *)getContactList:(NSInteger)page;
+ (LSKParamterEntity *)getUserTeamList:(NSInteger)page type:(NSInteger)type;
+ (LSKParamterEntity *)getUserTeamCount;
+ (LSKParamterEntity *)getUserSignCount;

+ (LSKParamterEntity *)getTaskMessage;

+ (LSKParamterEntity *)glodExchangeSilver:(NSInteger)money;
+ (LSKParamterEntity *)getExchangeRate;

+ (LSKParamterEntity *)attentionUser:(NSString *)userId isCare:(BOOL)isCare;
+ (LSKParamterEntity *)getOtherAttention:(NSInteger)page userId:(NSString *)userId;
+ (LSKParamterEntity *)spaceMessageDataWith:(NSString *)userId page:(NSInteger)page showType:(NSInteger)showType;

+ (LSKParamterEntity *)getHisttoryOrderWith:(NSString *)searchId page:(NSInteger)page showType:(NSInteger)showType;

+ (LSKParamterEntity *)widthdrawMoney:(NSString *)money;
+ (LSKParamterEntity *)widthdrawRecordList:(NSInteger)page month:(NSInteger)month year:(NSInteger)year;
+ (LSKParamterEntity *)rechargeRecordList:(NSInteger)page month:(NSInteger)month year:(NSInteger)year;

+ (LSKParamterEntity *)getlistUserModel:(NSInteger)page userId:(NSString *)userId;

+ (LSKParamterEntity *)reportOtherUser:(NSString *)uesrId content:(NSString *)content postId:(NSString *)postId;

+ (LSKParamterEntity *)getUserAndSystemNoticeList:(NSInteger)page type:(NSInteger)type;

+ (LSKParamterEntity *)getNoticeCount;
+ (LSKParamterEntity *)changeNoticeShow:(NSString *)msgId;
@end
