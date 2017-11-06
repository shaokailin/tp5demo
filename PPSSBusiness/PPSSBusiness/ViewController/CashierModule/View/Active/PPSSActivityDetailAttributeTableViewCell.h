//
//  PPSSPPSSActivityDetailAttributeTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSActivityDetailAttributeTableViewCell = @"PPSSActivityDetailAttributeTableViewCell";
typedef void (^ActivityIntensityBlock)(NSInteger type);
@interface PPSSActivityDetailAttributeTableViewCell : UITableViewCell
@property (nonatomic, copy) ActivityIntensityBlock intensityBlock;
- (void)setupContentWithSuport:(NSString *)support;
- (void)setupSuportType:(NSInteger)type;
@end
