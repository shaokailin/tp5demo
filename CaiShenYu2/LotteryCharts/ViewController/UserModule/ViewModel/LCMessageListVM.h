//
//  LCMessageListVM.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/22.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCMessageListVM : LSKBaseViewModel
@property (nonatomic, assign) NSInteger type;
-(void)getUserNoticeSetting;
- (void)changeUserSetting;
@end
