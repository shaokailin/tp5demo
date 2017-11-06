//
//  PPSSNoticeListModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSNoticeListModel.h"

@implementation PPSSNoticeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"noticeId" : @"id",
             };
}
@end
@implementation PPSSNoticeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [PPSSNoticeModel class],
             };
}
@end
