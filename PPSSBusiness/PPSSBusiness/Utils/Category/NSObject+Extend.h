//
//  NSObject+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)

/**
 空转钱的样式

 @return NSString
 */
- (id)nullTransformMoney;
/**
 空转数字的样式
 
 @return NSString
 */
- (id)nullTransformNumber;
/**
 空转字符串的样式
 
 @return NSString
 */
- (id)nullTransformString;

/**
 判断是否有值

 @return yes：有值
 */
- (BOOL)isHasValue;
@end
