//
//  PPSSSettingPasswordTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSSettingPasswordTableViewCell = @"PPSSSettingPasswordTableViewCell";
@interface PPSSSettingPasswordTableViewCell : UITableViewCell
- (void)setupCellContentWithLeft:(NSString *)left right:(NSString *)right;
@end
