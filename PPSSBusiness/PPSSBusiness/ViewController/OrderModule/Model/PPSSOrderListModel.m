//
//  PPSSOrderListModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderListModel.h"

@implementation PPSSOrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [PPSSOrderModel class],
             };
}
@end
@implementation PPSSOrderModel
- (void)setUserName:(NSString *)userName {
    _userName = KNullTransformString(userName);
}
@end
