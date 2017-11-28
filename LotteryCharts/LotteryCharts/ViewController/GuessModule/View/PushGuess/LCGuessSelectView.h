//
//  LCGuessSelectView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectTypeBlock)(NSInteger type);
@interface LCGuessSelectView : UIView
@property (nonatomic, copy) SelectTypeBlock selectBlock;
- (NSString *)getMoneyData;
- (NSString *)getNumberData;
- (NSString *)getSelectData;
@end
