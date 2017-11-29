//
//  LCPhotoTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhotoBlock)(BOOL isPhoto);
static NSString * const kLCPhotoTableViewCell = @"LCPhotoTableViewCell";
@interface LCPhotoTableViewCell : UITableViewCell
@property (nonatomic, copy) PhotoBlock block;
- (void)setupUserPhoto:(id)photoString;
@end
