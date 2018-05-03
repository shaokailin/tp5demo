//
//  NewWorkingRequestManage.h
//  Created by 敲代码mac1号 on 16/7/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NewWorkingRequestManage : NSObject




@property (nonatomic , copy) NSString *errorStr;

/*
 * GTE请求方法
 *
 * @param urlStr 请求地址
 * @param dic    请求参数
 * @param finish 请求成功的回调
 * @param failure  请求失败的回调
 */
+ (NewWorkingRequestManage *)newWork;


+ (void)requestGetWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure ;

/*
 * Post请求方法
 *
 * @param urlStr 请求地址
 * @param dic    请求参数
 * @param finish 请求成功的回调
 * @param failure  请求失败的回调
 */

+ (void)requestPostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure;



@end
