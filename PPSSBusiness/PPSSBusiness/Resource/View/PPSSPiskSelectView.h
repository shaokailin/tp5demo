//
//  PPSSPiskSelectView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSSPickView.h"
typedef void (^PickSelectBlock) (PickViewType type,NSString *content);
@interface PPSSPiskSelectView : UIView
@property (nonatomic, copy) PickSelectBlock pickBlock;
@property (nonatomic, assign) PickViewType type;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, assign) BOOL isAutoHidenForSure;
- (instancetype)initWithFrame:(CGRect)frame tabbarHeight:(CGFloat)height;
- (void)cancleSelectedClick;
- (void)setPickViewSource:(NSArray *)array;
- (void)showInView;
@end
