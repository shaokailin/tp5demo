//
//  LCUserLoginMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCUserMessageModel.h"
@interface LCUserLoginMessageModel : LSKBaseResponseModel
@property (nonatomic, strong) LCUserMessageModel *response;
@end
