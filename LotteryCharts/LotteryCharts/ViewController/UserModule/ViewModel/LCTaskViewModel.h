//
//  LCTaskViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCTaskModel.h"
@interface LCTaskViewModel : LSKBaseViewModel
@property (nonatomic, strong) LCTaskModel *taskModel;
- (void)getTaskMessage;
@end
