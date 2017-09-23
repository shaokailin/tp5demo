//
//  PPSSActivitySupportVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^ActivitySupportBlock) (NSString *content);
@interface PPSSActivitySupportVC : LSKBaseViewController
@property (nonatomic, copy) ActivitySupportBlock block;
@end
