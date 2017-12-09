//
//  LCReplySuccessModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCGuessReplyModel.h"
@interface LCReplySuccessModel : LSKBaseResponseModel
@property (nonatomic, strong) LCGuessReplyModel *response;
@end
