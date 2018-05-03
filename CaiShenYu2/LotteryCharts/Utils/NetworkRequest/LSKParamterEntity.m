//
//  LSKParamterEntity.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKParamterEntity.h"
#import "LSKPublicMethodUtil.h"
@implementation LSKParamterEntity
- (instancetype)init {
    if (self = [super init]) {
        _requestType = HTTPRequestType_POST;
    }
    return self;
}
@end
