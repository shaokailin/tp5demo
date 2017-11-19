//
//  LCRankingHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RankingHeaderBlock) (NSInteger type);
@interface LCRankingHeaderView : UIView
@property (nonatomic, copy) RankingHeaderBlock headerBlock;
@end
