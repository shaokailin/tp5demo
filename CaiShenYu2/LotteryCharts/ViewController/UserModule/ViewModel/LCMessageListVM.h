//
//  LCMessageListVM.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/22.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCUserSettingModel.h"
@interface LCMessageListVM : LSKBaseViewModel
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL changeValue;
@property (nonatomic, strong) LCUserSettingModel *model;
-(void)getUserNoticeSetting;
- (void)changeUserSetting;
@end
