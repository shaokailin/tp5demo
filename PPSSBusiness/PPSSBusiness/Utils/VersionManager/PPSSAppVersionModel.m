//
//  PPSSAppVersionModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppVersionModel.h"

@implementation PPSSAppVersionModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"download" : @"data.download",
             @"title" : @"data.title",
             @"version" : @"data.version",
             @"must" : @"data.must",
             @"content" : @"data.content",
             @"type" : @"data.type",
             };
}
@end
