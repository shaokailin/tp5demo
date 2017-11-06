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
- (void)initializeSignWithParams:(NSString *)param, ... {
    va_list args;
    va_start(args, param);
    NSMutableString *signString = [NSMutableString stringWithString:self.timestamp];
    NSInteger count = 0;
    for (NSString *arg = param; arg != nil; arg = va_arg(args, NSString*)){
        count ++;
        [signString appendString:arg];
    }
    va_end(args);
    [signString appendFormat:@"%ld",(long)count];
    [self.params setObject:[NSString MD5:signString] forKey:@"sign"];
}
- (NSMutableDictionary *)params {
    if (!_params) {
         _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"type",[LSKPublicMethodUtil getAppVersion],@"version",self.timestamp,@"timestamp", nil];
    }
    return _params;
}
- (NSString *)timestamp {
    if (!_timestamp) {
        _timestamp = NSStringFormat(@"%.0f",[[NSDate date]timeIntervalSince1970]);
    }
    return _timestamp;
}
@end
