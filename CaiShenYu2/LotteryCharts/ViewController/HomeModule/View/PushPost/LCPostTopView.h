//
//  LCPostTopView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PushBlock)(BOOL isPush);
@interface LCPostTopView : UIView
@property (nonatomic, copy) PushBlock pushBlock;
@property (weak, nonatomic) IBOutlet UITextField *moneyFied;

@end
