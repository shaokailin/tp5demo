//
//  LCPostAlertView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertBlock)(NSInteger clickIndex);
@interface LCPostAlertView : UIView
@property (nonatomic, copy) AlertBlock alertBlock;
@end
