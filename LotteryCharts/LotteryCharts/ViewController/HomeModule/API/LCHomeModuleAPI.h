//
//  LCHomeModuleAPI.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHomeModuleAPI : NSObject
+ (LSKParamterEntity *)pushPostEvent:(NSString *)title content:(NSString *)content media:(NSString *)media type:(NSInteger)type money:(NSString *)money vipMoney:(NSString *)vipMoney;

+ (LSKParamterEntity *)getOnLineAll;
+ (LSKParamterEntity *)getHomeHeaderMessage;
+ (LSKParamterEntity *)getHotPostList:(NSInteger)page;

+ (LSKParamterEntity *)getPostRanking:(NSInteger)page type:(NSInteger)type;
+ (LSKParamterEntity *)getkHistoryLotteryList:(NSInteger)page limitRow:(NSInteger)limit period_id:(NSString *)period_id;
@end
