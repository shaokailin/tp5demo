//
//  HSPDatePickView.h
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DatePickBlock) (NSDate *date);
@interface HSPDatePickView : UIView
@property (nonatomic, copy) DatePickBlock dateBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
- (void)showInView;
@end
