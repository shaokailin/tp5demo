//
//  LCHomeNoticeView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJScrollTextView2.h"
@interface LCHomeNoticeView : UIView<LMJScrollTextView2Delegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
- (void)setupContent:(NSArray *)content;
@end
