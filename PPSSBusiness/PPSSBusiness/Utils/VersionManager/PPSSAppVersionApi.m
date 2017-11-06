//
//  PPSSAppVersionApi.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppVersionApi.h"
#import "PPSSAppVersionModel.h"
static NSString * const kAppVersionApi = @"appVersion/findAppVersionNew";
@implementation PPSSAppVersionApi
+ (LSKParamterEntity *)getAppVersionData {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAppVersionApi;
    entity.responseObject = [PPSSAppVersionModel class];
    return entity;
}
@end
