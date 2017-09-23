//
//  NSTimer+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extend)

/**
 定时器 为了self避免循环引用

 @param inerval 时间断循环
 @param block 时间的触发
 @param repeats 是否循环
 @return 定时器
 */
+ (NSTimer *)lsk_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                          block:(void(^)(NSTimer *timer))block
                                        repeats:(BOOL)repeats;
+ (NSTimer *)initTimerWithTimeInterval:(NSTimeInterval)inerval
                                 block:(void (^)(NSTimer *timer))block
                               repeats:(BOOL)repeats
                              runModel:(NSRunLoopMode)mode;
//暂停
- (void)pauseTimer;
//继续
- (void)resumeTimer:(CGFloat)time;
@end
