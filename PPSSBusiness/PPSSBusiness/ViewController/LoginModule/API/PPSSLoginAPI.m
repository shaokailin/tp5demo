//
//  PPSSLoginAPI.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginAPI.h"
#import "PPSSLoginModel.h"
static NSString * const kLoginApi = @"";
@implementation PPSSLoginAPI
+ (LSKParamterEntity *)loginActionWith:(NSString *)account password:(NSString *)pwd {
    LSKParamterEntity *entity = [LSKParamterEntity new];
    entity.requestApi = kLoginApi;
    entity.requestType = HTTPRequestType_POST;
    entity.param = @{};
    entity.responseObject = [PPSSLoginModel class];
    return entity;
}
@end
