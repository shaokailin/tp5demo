//
//  NSDictionary+Check.m
//  MusicPlayer
//
//  Created by 陈永辉 on 17/2/7.
//  Copyright © 2017年 hxcj. All rights reserved.
//

#import "NSDictionary+Check.h"

@implementation NSDictionary (Check)

- (BOOL)notNUll:(NSString *)key {
    //不为空
    if ([self objectForKey:key] && [self objectForKey:key] != [NSNull null]) {
        return YES;
    }else {
        return NO;
    }
}

@end
