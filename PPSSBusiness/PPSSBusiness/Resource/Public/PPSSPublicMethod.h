//
//  PPSSPublicMethod.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSPublicMethod : NSObject

/**
 支付类型的转换

 @param type payType
 @return 参数
 */
+ (NSString *)returnPayTypeStringWithType:(NSInteger)type;
@end
