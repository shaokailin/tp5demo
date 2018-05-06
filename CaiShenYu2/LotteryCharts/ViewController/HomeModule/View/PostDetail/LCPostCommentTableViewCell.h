//
//  LCPostCommentTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCPostCommentTableViewCell = @"LCPostCommentTableViewCell";
@interface LCPostCommentTableViewCell : UITableViewCell
@property (nonatomic, copy) PhotoClickBlock photoBlock;
- (void)setupPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId count:(NSInteger)count time:(NSString *)time content:(NSString *)content isHiden:(BOOL)isHiden;
@end
