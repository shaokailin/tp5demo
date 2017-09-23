//
//  NSArray+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)
+ (instancetype)arrayWithPlist:(NSString *)name {
    if ([name isHasValue]) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
        if (plistPath) {
            return [[NSArray alloc]initWithContentsOfFile:plistPath];;
        }
    }
    return [[NSArray alloc]init];
}
@end
