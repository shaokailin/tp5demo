//
//  LCHomeHeaderView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
//1目录，2.搜索 3.banner 4.func 5.福彩3d more
typedef void (^HeaderViewBlock) (NSInteger type,id actionParam);
@interface LCHomeHeaderView : UIView
@property (nonatomic, copy) HeaderViewBlock headerBlock;
@property (nonatomic, assign) NSInteger searchIndex;
- (void)setupHotLineCount:(NSString *)count;
- (void)setupBannerData:(NSArray *)banner;
- (void)setupNotice:(NSArray *)content;
- (void)setup3DMessage:(NSArray *)array;
- (void)setup5DMessage:(id)data;
@end
