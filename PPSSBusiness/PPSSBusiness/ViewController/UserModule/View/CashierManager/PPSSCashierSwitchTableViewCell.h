//
//  PPSSCashierSwitchTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSCashierSwitchTableViewCell = @"PPSSCashierSwitchTableViewCell";
@interface PPSSCashierSwitchTableViewCell : UITableViewCell
- (void)setupSwitchContentWithTitle:(NSString *)title isSwitch:(NSInteger)isSwitch;
@end
