//
//  PPSSPickView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PickViewType){
    PickViewType_Source = 1,
    PickViewType_Time = 2,
    PickViewType_Date = 3,
};
@interface PPSSPickView : UIView
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, assign) PickViewType pickViewType;
- (void)setPickViewSource:(NSArray *)array;

- (NSString *)returnCurrentSelectString;
@end
