//
//  PPSSPublicMethod.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPublicMethod.h"

@implementation PPSSPublicMethod
+ (NSString *)returnPayTypeStringWithType:(NSInteger)type {
    NSString *title = nil;
    switch (type) {
        case -1:
            title = @"未支付";
            break;
        case 1:
            title = @"通用余额支付";
            break;
        case 2:
            title = @"本店余额支付";
            break;
        case 3:
            title = @"支付宝支付";
            break;
        case 4:
            title = @"微信支付";
        case 9:
            title = @"混合支付";
        default:
            break;
    }
    return title;
}
@end
