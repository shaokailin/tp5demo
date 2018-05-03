//
//  LCSelectTwoYardsView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCSelectTwoYardsView : UIView
@property (weak, nonatomic) IBOutlet UITextField *payField;
@property (weak, nonatomic) IBOutlet UITextField *countField;
- (NSString *)getSelect;
@end
