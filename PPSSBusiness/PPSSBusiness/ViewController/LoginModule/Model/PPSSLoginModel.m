//
//  PPSSLoginModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginModel.h"

@implementation PPSSLoginModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banners" : [PPSSBannerModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"token" : @"data.token",
             @"power" : @"data.power",
             @"username" : @"data.username",
             @"phone" : @"data.phone",
             @"userId" : @"data.userId",
             @"qcode" : @"data.qcode",
             @"incomeMoney" : @"data.incomeMoney",
             @"incomeNumber" : @"data.incomeNumber",
             @"members" : @"data.members",
             @"banners" : @"data.banners",
             @"shopName" : @"data.shopName",
             @"logo" : @"data.logo"
             
             };
}

@end
@implementation PPSSBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"bannerId" : @"id",
             };
}
@end
