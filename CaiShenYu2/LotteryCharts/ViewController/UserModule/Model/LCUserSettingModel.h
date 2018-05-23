//
//  LCUserSettingModel.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/23.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCUserSettingModel : LSKBaseResponseModel
@property (nonatomic, assign) BOOL comment_reply;
@property (nonatomic, assign) BOOL focus;
@property (nonatomic, assign) BOOL reward;
@property (nonatomic, assign) BOOL system;
@end
