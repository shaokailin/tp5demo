//
//  LCGuessHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderBlock)(NSInteger type);
@interface LCGuessHeaderView : UIView
@property (nonatomic, copy) HeaderBlock hederBlock;
@property (weak, nonatomic) IBOutlet UITextField *countField;
- (void)setupContentTitle:(NSString *)title money:(NSString *)money count:(NSString *)count number1:(NSString *)number1 number2:(NSString *)number2 type:(NSInteger)type;
@end
