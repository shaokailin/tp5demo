//
//  LSKHttpManager.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSKParamterEntity;
@interface LSKHttpManager : NSObject
+ (instancetype)sharedLSKHttpManager;

/**
 请求的分装

 @param entity 请求所需参数的对象实体
 @param success 成功返回
 @param failure 失败返回
 */
+ (NSUInteger)httpReuquestWithEntity:(LSKParamterEntity *)entity success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

// 移除当前未加载完成的网络请求
- (void)removeHttpLoadingByIdentifier:(NSArray *)identifierArray;
@end
