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
@end
