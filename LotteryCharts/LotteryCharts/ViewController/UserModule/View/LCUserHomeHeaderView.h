//
//  LCUserHomeHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UserHomeHeaderBlock)(NSInteger type);//1:更背景 2：更换头像 3.打卡
@interface LCUserHomeHeaderView : UIView
@property (nonatomic, copy) UserHomeHeaderBlock punchBlock;
- (void)setupContentWithName:(NSString *)name userid:(NSString *)userId attention:(NSString *)attention teem:(NSString *)teem;
- (void)changeUserPhoto:(id)photo;
- (void)changeBgImage:(id)bgImage;
@end
