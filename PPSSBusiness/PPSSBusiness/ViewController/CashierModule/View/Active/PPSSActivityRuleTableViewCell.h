//
//  PPSSActivityRuleTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/25.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RuleInputBlock) (NSInteger type, NSString *rule);
static NSString * const kPPSSActivityRuleTableViewCell = @"PPSSActivityRuleTableViewCell";
@interface PPSSActivityRuleTableViewCell : UITableViewCell
- (void)setupPointValue:(NSString *)point money:(NSString *)money isEdit:(BOOL)isEdit;
@property (nonatomic, copy) RuleInputBlock ruleBlock;
@end
