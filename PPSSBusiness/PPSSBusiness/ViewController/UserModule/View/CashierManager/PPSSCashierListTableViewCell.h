//
//  PPSSCashierListTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSCashierListTableViewCell = @"PPSSCashierListTableViewCell";
@interface PPSSCashierListTableViewCell : UITableViewCell
- (void)setupContentWithName:(NSString *)name phone:(NSString *)phone;
@end
