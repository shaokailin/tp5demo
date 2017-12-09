//
//  LCGuessModuleAPI.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGuessModuleAPI : NSObject
+ (LSKParamterEntity *)pushGuessEvent:(NSInteger)type content:(NSString *)content answer:(NSString *)answer money:(NSString *)money number:(NSString *)number title:(NSString *)title;
+ (LSKParamterEntity *)guessMainList:(NSInteger)page;
+ (LSKParamterEntity *)guessOldList:(NSInteger)page;
+ (LSKParamterEntity *)guessMainMoreList:(NSInteger)page period_id:(NSString *)period_id;

+ (LSKParamterEntity *)getGuessDetail:(NSString *)quiz_id;
+ (LSKParamterEntity *)getGuessDetail:(NSString *)quiz_id page:(NSInteger)page;
+ (LSKParamterEntity *)sendGuessComment:(NSString *)quiz_id message:(NSString *)message;
+ (LSKParamterEntity *)betGuessMessage:(NSString *)quiz_id period_id:(NSString *)period_id betting_num:(NSString *)betting_num;
@end
