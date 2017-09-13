
//
//  HttpUtils.m
//  MusicPlayer
//
//  Created by 陈永辉 on 17/2/7.
//  Copyright © 2017年 hxcj. All rights reserved.
//

#import "HttpUtils.h"
#import "NSDictionary+Check.h"


@implementation HttpUtils : NSObject

+ (void)getRequestWithURL:(NSString *)requestURL withParameters:(NSDictionary*)parameters withResult:(NetDataSuccessBlock)successResult withError:(NetDataFailBlock)errorResult {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain", @"application/json"]];
    NSString *encodeURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; //修改数据请求格式 为Json类型
    [manager GET:encodeURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * task,  id  response) {
        successResult(response);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(@"请求失败,可能是网络有问题", error);
        
    }];
    
}

+ (void)postRequestWithURL:(NSString *)requestURL withParameters:(NSDictionary*)parameters withResult:(NetDataSuccessBlock)successResult withError:(NetDataFailBlock)errorResult {
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    
    [manage POST:requestURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject) {
            if ([responseObject notNUll:@"code"]) {
                NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
                if ([code isEqualToString:@"1"]) {
                    successResult(responseObject);
                }else {
                    NSString *msg = responseObject[@"msg"];
                    errorResult(msg,nil);
                }
            }else {
                successResult(responseObject);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(@"请求失败,可能是网络有问题", error);
        
    }];
    

}


//开始网络监控
+ (void)startReachabilityMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
//当网络状况发生变化的时候
+ (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:block];
}

+ (void)download:(NSString *)urlString finish:(void(^)(NSData *data))finishBlock {
    if (!urlString) {
        if (finishBlock) {
            finishBlock(nil);
        }
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [caches stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *destinationURL = [NSURL fileURLWithPath:path];
        [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:nil];
        return destinationURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            NSData *data = [NSData dataWithContentsOfFile:[filePath path]];
            finishBlock(data);
        }
    }];
    
}

@end
