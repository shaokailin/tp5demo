//
//  LCPublicNoticeCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCPublicNoticeCell = @"LCPublicNoticeCell";
typedef void (^detailBlock)(id clickDetail);
@interface LCPublicNoticeCell : UITableViewCell
@property (nonatomic, copy) detailBlock block;
- (void)setupCellContent:(NSString *)title detail:(NSString *)detail isShowDetail:(BOOL)isShow;
@end
