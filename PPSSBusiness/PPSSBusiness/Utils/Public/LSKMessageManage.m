//
//  LSKMessageManage.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKMessageManage.h"

@implementation LSKMessageManage
{
    NSUserDefaults *_userDefaults;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
- (NSUserDefaults *)getUserDefault
{
    return _userDefaults;
}
#pragma mark 存储数据

- (void)setMessageManagerForObjectWithKey:(nonnull NSString *)key value:(id)value {
    if (value != nil) {
        [_userDefaults setObject:value forKey:key];
    }else
    {
        [_userDefaults removeObjectForKey:key];
    }
    [_userDefaults synchronize];
}
- (id)getMessageManagerForObjectWithKey:(nonnull NSString *)key {
    return [_userDefaults objectForKey:key];
}

- (void)setMessageManagerForBoolWithKey:(nonnull NSString *)key value:(BOOL)value {
    [_userDefaults setBool:value forKey:key];
    [_userDefaults synchronize];
}
- (BOOL)getMessageManagerForBoolWithKey:(nonnull NSString *)key {
    return [_userDefaults boolForKey:key];
}

- (void)setMessageManagerForIntegerWithKey:(nonnull NSString *)key value:(NSInteger)value {
    [_userDefaults setInteger:value forKey:key];
    [_userDefaults synchronize];
}
- (NSInteger)getMessageManagerForIntegerWithKey:(nonnull NSString *)key {
    return [_userDefaults integerForKey:key];
}

- (void)setMessageManagerForFloatWithKey:(nonnull NSString *)key value:(CGFloat)value {
    [_userDefaults setFloat:value forKey:key];
    [_userDefaults synchronize];
}
- (CGFloat)getMessageManagerForFloatWithKey:(nonnull NSString *)key {
    return [_userDefaults floatForKey:key];
}

- (void)removeMessageManagerForKey:(nonnull NSString *)key {
    [_userDefaults removeObjectForKey:key];
    [_userDefaults synchronize];
}
@end
