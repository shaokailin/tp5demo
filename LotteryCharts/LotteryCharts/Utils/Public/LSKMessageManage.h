//
//  LSKMessageManage.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSKMessageManage : NSObject
- (NSUserDefaults *_Nullable)getUserDefault;
/**
 对象保存
 
 @param key 保存的对应键
 @param value 对象值
 */
- (void)setMessageManagerForObjectWithKey:(nonnull NSString *)key value:(id _Nullable )value;

/**
 获取对象
 
 @param key 对象对应的键
 @return 对象
 */
- (id _Nullable )getMessageManagerForObjectWithKey:(nonnull NSString *)key;
/**
 BOOL保存
 
 @param key 保存的对应键
 @param value BOOL值
 */
- (void)setMessageManagerForBoolWithKey:(nonnull NSString *)key value:(BOOL)value;
- (BOOL)getMessageManagerForBoolWithKey:(nonnull NSString *)key;
/**
 Integer保存
 
 @param key 保存的对应键
 @param value Integer值
 */
- (void)setMessageManagerForIntegerWithKey:(nonnull NSString *)key value:(NSInteger)value;
- (NSInteger)getMessageManagerForIntegerWithKey:(nonnull NSString *)key;
/**
 Float保存
 
 @param key 保存的对应键
 @param value Float值
 */
- (void)setMessageManagerForFloatWithKey:(nonnull NSString *)key value:(CGFloat)value;
- (CGFloat)getMessageManagerForFloatWithKey:(nonnull NSString *)key;

/**
 移除数据
 
 @param key 保存的对应键
 */
- (void)removeMessageManagerForKey:(nonnull NSString *)key;
@end
