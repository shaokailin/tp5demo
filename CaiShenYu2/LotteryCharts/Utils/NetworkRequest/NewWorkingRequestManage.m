//
//  NewWorkingRequestManage.m
//  Created by 敲代码mac1号 on 16/7/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "NewWorkingRequestManage.h"


@implementation NewWorkingRequestManage

+ (NewWorkingRequestManage *)newWork {
    static  NewWorkingRequestManage *newWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        newWork = [[NewWorkingRequestManage alloc] init];
    });
    return newWork;
}


//GET请求
+ (void)requestGetWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];    //添加manager 配置信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);

        finish([self jsonDataTransformToDictionary:responseObject]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);

        if (error) {
            failure(error);
        }
    }];
}

+ (void)requestPostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    

    //添加manager 配置信息
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        
        
        finish([self jsonDataTransformToDictionary:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (error) {
//            [MBProgressHUD showMessage:@"系统错误" toView:nil];
            MyLog(@"链接：%@\n请求参数%@",urlStr,dic);

            failure(error);
        }
    }];
    
}



+ (id)jsonDataTransformToDictionary :(NSData *)data {
    NSDictionary *responseDistionary = nil;
    //java 服务器出现奔溃的时候会返回 _NSZeroData 的<> 格式的错误
    if (data != nil && ![data isKindOfClass:[NSClassFromString(@"_NSZeroData") class]]) {
        NSError *error = nil;
        responseDistionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            LSKLog(@"请求数据问题====%@",error);
            return nil;
        }
    }
    return responseDistionary;
}


@end
