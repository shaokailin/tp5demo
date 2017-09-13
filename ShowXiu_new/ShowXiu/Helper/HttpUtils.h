//
//  HttpUtils.h
//  MusicPlayer
//
//  Created by 陈永辉 on 17/2/7.
//  Copyright © 2017年 hxcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^NetDataSuccessBlock)(id result);
typedef void(^NetDataFailBlock)(NSString *msg, NSError *error);

@interface HttpUtils : NSObject

//GET请求
+ (void)getRequestWithURL:(NSString *)requestURL withParameters:(NSDictionary*)parameters withResult:(NetDataSuccessBlock)successResult withError:(NetDataFailBlock)errorResult;

//POST请求
+ (void)postRequestWithURL:(NSString *)requestURL withParameters:(NSDictionary*)parameters withResult:(NetDataSuccessBlock)successResult withError:(NetDataFailBlock)errorResult;

//开始网络监控
+ (void)startReachabilityMonitoring;
//当网络状况发生变化的时候
+ (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;

@end
