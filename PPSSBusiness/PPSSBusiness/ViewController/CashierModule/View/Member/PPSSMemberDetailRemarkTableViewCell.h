//
//  PPSSMemberDetailRemarkTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSMemberDetailRemarkTableViewCell = @"PPSSMemberDetailRemarkTableViewCell";
@interface PPSSMemberDetailRemarkTableViewCell : UITableViewCell
- (void)setupContentWithLeft:(NSString *)left remark:(NSString *)remark;
@end
