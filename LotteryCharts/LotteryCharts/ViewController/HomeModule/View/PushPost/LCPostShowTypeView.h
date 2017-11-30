//
//  LCPostShowTypeView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ShowTypeBlock)(NSInteger type);
@interface LCPostShowTypeView : UIView
@property (nonatomic, assign) NSInteger currentShow;
@property (nonatomic, copy) ShowTypeBlock typeBlock;
@property (weak, nonatomic) IBOutlet UITextField *moneyFied;
@end
