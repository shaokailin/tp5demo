//
//  LCMeCommentCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCMeCommentCell = @"LCMeCommentCell";
@interface LCMeCommentCell : UITableViewCell
- (void)setupCellContent:(NSString *)name time:(NSString *)time content:(NSString *)content img:(NSString *)image type:(NSInteger)type isRead:(BOOL)isRead;
@end
