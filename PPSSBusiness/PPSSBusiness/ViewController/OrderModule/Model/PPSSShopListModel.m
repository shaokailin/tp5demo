//
//  PPSSShopListModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShopListModel.h"

@implementation PPSSShopListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [PPSSShopModel class],
             };
}
@end
@implementation PPSSShopModel
@end
