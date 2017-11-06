//
//  PPSSActivityDetailTimeTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSActivityDetailTimeTableViewCell = @"PPSSActivityDetailTimeTableViewCell";
@class PPSSActivityDetailTimeTableViewCell;
typedef NS_ENUM(NSInteger,ActivityTimeExitType) {
    ActivityTimeExitType_Start,
    ActivityTimeExitType_End,
    ActivityTimeExitType_Delete
};
typedef void (^ActivityTimeBlock)(PPSSActivityDetailTimeTableViewCell *clickCell,ActivityTimeExitType type);
@interface PPSSActivityDetailTimeTableViewCell : UITableViewCell
- (void)setupContentWithStart:(NSString *)start end:(NSString *)end isShowDele:(BOOL)isShow index:(NSInteger)index;
- (void)setupContentWithStart:(NSString *)start end:(NSString *)end;
@property (nonatomic, copy) ActivityTimeBlock exitBlock;
@end
