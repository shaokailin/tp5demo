//
//  LCAttentionTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCAttentionTableViewCell = @"LCAttentionTableViewCell";
@interface LCAttentionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *atentionBtn;

@property (nonatomic, copy) PhotoClickBlock photoBlock;
@property (nonatomic, copy) void(^myBlock)(UIButton *sender);

- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId glodCount:(NSString *)glodCount yinbiCount:(NSString *)ybcount isShow:(BOOL)isShow;
@end
