//
//  PPSSLoginAPI.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSLoginAPI : NSObject
+ (LSKParamterEntity *)loginActionWith:(NSString *)account password:(NSString *)pwd;
@end
