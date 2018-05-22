//
//  LCMessageListVM.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/22.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMessageListVM.h"
#import "LCUserModuleAPI.h"
@interface LCMessageListVM ()
{
    BOOL _laseValue;
}
@property (nonatomic, strong) RACCommand *settingListCommand;
@property (nonatomic, strong) RACCommand *settingChangeCommand;
@end
@implementation LCMessageListVM
- (void)getUserNoticeSetting {
    [SKHUD showLoadingDotInWindow];
    [self.settingListCommand execute:nil];
}
- (void)changeUserSetting {
    
}
@end
