//
//  LCNameInputTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCNameInputTableViewCell = @"LCNameInputTableViewCell";
typedef void (^NameChangeBlock) (NSString *name,NSInteger type);
@interface LCNameInputTableViewCell : UITableViewCell
@property (nonatomic, copy) NameChangeBlock nameBlock;
- (void)setupCellContentWithName:(NSString *)name type:(NSInteger)type;
@end
