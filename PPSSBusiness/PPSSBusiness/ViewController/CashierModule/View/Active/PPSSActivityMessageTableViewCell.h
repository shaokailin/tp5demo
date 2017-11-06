//
//  PPSSActivityMessageTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPSSActivityMessageTableViewCell;
typedef void (^ActivityAddBlock)(PPSSActivityMessageTableViewCell *cell);
static NSString * const kPPSSActivityMessageTableViewCell = @"PPSSActivityMessageTableViewCell";
@interface PPSSActivityMessageTableViewCell : UITableViewCell
@property (nonatomic, copy) ActivityAddBlock addBlock;
- (void)setupContentWithTitle:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon;
@end
