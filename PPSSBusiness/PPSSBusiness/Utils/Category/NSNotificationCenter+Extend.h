//
//  NSNotificationCenter+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Extend)

/**
 通知消息

 @param name key
 @param object 推送的对象
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object;

/**
 通知消息

 @param name key
 @param object 推送的对象
 @param userInfo 推送的内容
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo;

/**
  通知消息

 @param name key
 @param object 推送的对象
 @param userInfo 推送内容
 @param wait 等待时间后通知
 */
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;
@end
