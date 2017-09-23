//
//  NSObject+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSObject+Extend.h"

@implementation NSObject (Extend)
- (id)nullTransformMoney {
    if (![self isHasValue]) {
        return @"0.00";
    }
    return self;
}

- (id)nullTransformNumber {
    if (![self isHasValue]) {
        return @"0";
    }
    return self;
}
- (id)nullTransformString {
    if (![self isHasValue]) {
        return @"";
    }
    return self;
}

- (BOOL)isHasValue {
    if (!self || [self isKindOfClass:[NSNull class]] || (([NSStringFromClass([self class])isEqualToString:@"__NSCFConstantString"] || [NSStringFromClass([self class])isEqualToString:@"__NSCFString"]) &&  (((NSString *)self).length == 0 || [(NSString *)self isEqualToString:@""]))) {
        return NO;
    }
    return YES;
}



@end
