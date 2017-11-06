//
//  NSTimer+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSTimer+Extend.h"
#import "LSKPublicMethodUtil.h"
@implementation NSTimer (Extend)
+ (NSTimer *)initTimerWithTimeInterval:(NSTimeInterval)inerval block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats runModel:(NSRunLoopMode)mode{
    NSTimer *timer = nil;
    if (@available(iOS 10.0, *)) {
        timer = [NSTimer timerWithTimeInterval:inerval repeats:repeats block:block];
    } else {
        timer = [NSTimer timerWithTimeInterval:inerval target:self selector:@selector(lsk_blcokInvoke:) userInfo:[block copy] repeats:repeats];
    }
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:mode];
    return timer;
}

+ (NSTimer *)lsk_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    //ios10 以后直接使用系统自带的。
    if (@available(iOS 10.0, *)) {
        return [NSTimer scheduledTimerWithTimeInterval:inerval repeats:repeats block:block];
    } else {
        return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(lsk_blcokInvoke:) userInfo:[block copy] repeats:repeats];
    }
}

+ (void)lsk_blcokInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(nil);
    }
}
//暂停
- (void)pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}
//继续定时
- (void)resumeTimer:(CGFloat)time {
    
    if (![self isValid]) {
        return ;
    }
    if (time > 0) {
        [self setFireDate:[NSDate dateWithTimeInterval:time sinceDate:[NSDate date]]];
    }else {
        [self setFireDate:[NSDate date]];
    }
}
@end
