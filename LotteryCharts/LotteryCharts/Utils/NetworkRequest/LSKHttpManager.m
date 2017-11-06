//
//  LSKHttpManager.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKHttpManager.h"
#import "SynthesizeSingleton.h"
#import <AFNetworking/AFNetworking.h>
#import "LSKMediaParamterEntity.h"
static const NSInteger kRequestTimeOutTime = 10;
static const CGFloat kImageJPEGCompressRate = 0.8;
@interface LSKHttpManager ()
@property (nonatomic ,strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic ,strong)NSMutableDictionary *httpsLoadingDictionary;
@end
@implementation LSKHttpManager
SYNTHESIZE_SINGLETON_CLASS(LSKHttpManager);

+ (NSUInteger)httpReuquestWithEntity:(LSKParamterEntity *)entity success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    NSUInteger identifier = -1;
    if (entity) {
        switch (entity.requestType) {
            case 0:
            {
                identifier = [[LSKHttpManager sharedLSKHttpManager]_getReuqestWithApiPath:entity.requestApi params:entity.params success:success failure:failure];
                break;
            }
            case 2:
            {
                LSKMediaParamterEntity *mediaEntity = (LSKMediaParamterEntity *)entity;
                identifier =  [[LSKHttpManager sharedLSKHttpManager]_uploadImageReuqestWithApiPath:mediaEntity.requestApi params:mediaEntity.params name:mediaEntity.name type:mediaEntity.uploadType medias:mediaEntity.mediaArray success:success failure:failure];
                break;
            }
            case 1:
            default:
                identifier =  [[LSKHttpManager sharedLSKHttpManager]_postReuqestWithApiPath:entity.requestApi params:entity.params success:success failure:failure];
                break;
        }
    }
    return identifier;
}

#pragma mark - 网络请求
/**
 GET
 
 @param api 请求的API
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @return 唯一标示
 */
- (NSUInteger)_getReuqestWithApiPath:(NSString *)api params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    WS(ws)
    NSURLSessionDataTask *seccionDataTask = [self.sessionManager GET:api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ws removeLoadingSessionDataTask:task];
        id dictionary = [LSKPublicMethodUtil jsonDataTransformToDictionary:responseObject];
        if (dictionary) {
            success(task.taskIdentifier, dictionary);
        }else {
            failure(task.taskIdentifier, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ws removeLoadingSessionDataTask:task];
        failure(task.taskIdentifier, error);
    }];
    [self addCurrentLoadingSessionDataTask:seccionDataTask];
    return seccionDataTask.taskIdentifier;
}
/**
 POST
 
 @param api 请求的API
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @return 唯一标示
 */
- (NSUInteger)_postReuqestWithApiPath:(NSString *)api params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    WS(ws)
    NSURLSessionDataTask *seccionDataTask = [self.sessionManager POST:api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ws removeLoadingSessionDataTask:task];
        id dictionary = [LSKPublicMethodUtil jsonDataTransformToDictionary:responseObject];
        if (dictionary) {
            success(task.taskIdentifier, dictionary);
        }else {
            failure(task.taskIdentifier, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ws removeLoadingSessionDataTask:task];
        failure(task.taskIdentifier, error);
    }];
    [self addCurrentLoadingSessionDataTask:seccionDataTask];
    return seccionDataTask.taskIdentifier;
}
/**
 上传图片
 
 @param api 请求的API
 @param params 参数
 @param name 文件上传字段
 @param type 图片类型
 @param mediasArray 图片数组
 @param success 成功回调
 @param failure 失败回调
 @return 唯一标示
 */
- (NSUInteger)_uploadImageReuqestWithApiPath:(NSString *)api params:(NSDictionary *)params name:(NSString *)name type:(LSKUploadMediaType)type medias:(NSArray *)mediasArray success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    WS(ws)
    if (!mediasArray || mediasArray.count == 0) {
        return [self _postReuqestWithApiPath:api params:params success:success failure:failure];
    }else {
        NSURLSessionDataTask *seccionDataTask = [self.sessionManager POST:api parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSString *fileName = nil;
            NSData *imageData = nil;
            NSString *mimeType = nil;
            for (UIImage *image in mediasArray) {
                if (type == LSKUploadMediaType_PNG) {
                    fileName = @"uploadImage.png";
                    mimeType = @"image/png";
                    imageData = UIImagePNGRepresentation(image);
                }else {
                    fileName = @"uploadImage.jpg";
                    mimeType = @"image/jpeg";
                    imageData = UIImageJPEGRepresentation(image, kImageJPEGCompressRate);
                }
                [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [ws removeLoadingSessionDataTask:task];
            id dictionary = [LSKPublicMethodUtil jsonDataTransformToDictionary:responseObject];
            if (dictionary) {
                success(task.taskIdentifier, dictionary);
            }else {
                failure(task.taskIdentifier, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ws removeLoadingSessionDataTask:task];
            failure(task.taskIdentifier, error);
        }];
        [self addCurrentLoadingSessionDataTask:seccionDataTask];
        return seccionDataTask.taskIdentifier;
    }
}

#pragma mark - 网络请求的取消
//保存单个请求的任务，以便 取消
- (void)addCurrentLoadingSessionDataTask :(NSURLSessionDataTask *)seccionDataTask {
    [self.httpsLoadingDictionary setObject:seccionDataTask forKey:@(seccionDataTask.taskIdentifier)];
}
//移除http 请求 根据 NSURLSessionDataTask 
- (void)removeLoadingSessionDataTask :(NSURLSessionDataTask *)seccionDataTask {
    if (self.httpsLoadingDictionary.allKeys.count > 0 && [self.httpsLoadingDictionary.allKeys containsObject:@(seccionDataTask.taskIdentifier)]) {
        [self.httpsLoadingDictionary removeObjectForKey:@(seccionDataTask.taskIdentifier)];
    }
    [seccionDataTask cancel];
}
//移除http 请求 根据 NSURLSessionDataTask 的taskIdentifier
- (void)removeHttpLoadingByIdentifier:(NSArray *)identifierArray {
    for (NSNumber *taskIdentifier in identifierArray) {
        if (self.httpsLoadingDictionary.allKeys.count > 0 && [self.httpsLoadingDictionary.allKeys containsObject:taskIdentifier]) {
            NSURLSessionDataTask *seccionDataTask = [self.httpsLoadingDictionary objectForKey:taskIdentifier];
            if (seccionDataTask) {
                [seccionDataTask cancel];
                [self.httpsLoadingDictionary removeObjectForKey:taskIdentifier];
            }
        }
    }
}

#pragma mark -初始化数据
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        //超时时间长
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOutTime;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //设置并发最多个数
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        //设置回传接受类型
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置服务器响应头可接手的样式
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",nil];
        //设置https的证书
        if (KJudgeIsNullData(HTTPS_CA_NAME)) {
            _sessionManager.securityPolicy = [self _setupHttpsSecurityPolicy];
        }
    }
    return _sessionManager;
}
//初始化 加载的保存hash表
- (NSMutableDictionary *)httpsLoadingDictionary
{
    if (!_httpsLoadingDictionary) {
        _httpsLoadingDictionary = [[NSMutableDictionary alloc]initWithCapacity:3];
    }
    return _httpsLoadingDictionary;
}
#pragma mark -设置请求证书
- (AFSecurityPolicy *)_setupHttpsSecurityPolicy {
    NSString *cerPath = nil;//证书的路径
        cerPath = [[NSBundle mainBundle] pathForResource:HTTPS_CA_NAME ofType:HTTPS_CA_TYPE];
    if (cerPath == nil) {
        return nil;
    }
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    return securityPolicy;
}

@end
