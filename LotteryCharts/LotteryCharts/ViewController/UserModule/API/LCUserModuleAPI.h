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

+ (LSKParamterEntity *)updateUserMessage:(NSString *)photoUrl sex:(NSString *)sex nickname:(NSString *)nickname birthday:(NSString *)birthday;

+ (LSKParamterEntity *)getUsermModuleMessage;

+ (LSKParamterEntity *)userSignEvent;
@end
