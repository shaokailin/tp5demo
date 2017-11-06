//
//  PPSSMemberDetailTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSMemberDetailTableViewCell = @"PPSSMemberDetailTableViewCell";
@interface PPSSMemberDetailTableViewCell : UITableViewCell
- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right type:(NSInteger)type;
@end
