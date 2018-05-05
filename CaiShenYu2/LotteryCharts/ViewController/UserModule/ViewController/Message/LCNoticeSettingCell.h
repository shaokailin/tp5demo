//
//  LCNoticeSettingCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NoticeClickBlock)(id clickCell,BOOL state);
static NSString * const kLCNoticeSettingCell = @"LCNoticeSettingCell";
@interface LCNoticeSettingCell : UITableViewCell
@property (nonatomic, copy) NoticeClickBlock clickBlock;
- (void)setupCellContent:(NSString *)title state:(BOOL)state;
@end
