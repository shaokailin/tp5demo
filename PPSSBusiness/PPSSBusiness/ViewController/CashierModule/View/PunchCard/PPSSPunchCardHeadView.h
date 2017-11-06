//
//  PPSSPunchCardHeadView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/11/4.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OffLineCashierBlock)(NSInteger type);
@interface PPSSPunchCardHeadView : UIView
@property (nonatomic, copy) OffLineCashierBlock cashierBlock;

- (void)updateTimeEvent;
- (void)setupLineNameWithTime:(NSString *)timeString name:(NSString *)name;
@end
