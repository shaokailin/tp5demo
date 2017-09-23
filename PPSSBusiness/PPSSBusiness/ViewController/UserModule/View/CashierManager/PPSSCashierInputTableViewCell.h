//
//  PPSSCashierInputTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSCashierInputTableViewCell = @"PPSSCashierInputTableViewCell";
@interface PPSSCashierInputTableViewCell : UITableViewCell
- (void)setupInputContentWithTitle:(NSString *)title content:(NSString *)content index:(NSInteger)index;
@end
