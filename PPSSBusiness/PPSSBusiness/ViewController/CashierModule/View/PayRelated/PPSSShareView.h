//
//  PPSSShareView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/24.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ShareTypeBlock)(NSInteger shareType);
@interface PPSSShareView : UIView
- (instancetype)initWithShareBlock:(ShareTypeBlock)typeBlock tabbarHeight:(CGFloat)height;
+ (BOOL)isCanShareForPlatforms;
- (void)shopInView;
@end
