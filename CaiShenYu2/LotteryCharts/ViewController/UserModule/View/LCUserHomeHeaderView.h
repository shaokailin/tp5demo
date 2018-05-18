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
- (instancetype)initWithFrame:(CGRect)frame isHome:(BOOL)isHome;
- (void)setupContentWithName:(NSString *)name userid:(NSString *)userId attention:(NSString *)attention teem:(NSString *)teem photo:(NSString *)photo fans:(NSString *)fans;
- (void)setupContentWithAttention:(NSString *)attention teem:(NSString *)teem fans:(NSString *)fans;
- (void)updateUserMessage;
- (void)isShowPunchCard:(BOOL)isShow;
- (void)changeUserPhoto:(id)photo;
- (void)changeBgImage:(id)bgImage;
@end
