//
//  LCSignHeaderView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SignClickBlock)(BOOL sign);
@interface LCSignHeaderView : UIView
@property (nonatomic, copy) SignClickBlock signBlock;
@property (nonatomic, assign) BOOL isSign;
- (void)changeSingAll:(NSArray *)array;
- (void)signForToday:(NSInteger)week;
- (void)setupSignIdentifier:(NSArray *)array;
@end
