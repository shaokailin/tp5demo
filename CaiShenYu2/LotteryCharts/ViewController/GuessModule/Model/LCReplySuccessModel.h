//
//  LCReplySuccessModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCPostReplyModel.h"
@interface LCReplySuccessModel : LSKBaseResponseModel
@property (nonatomic, strong) LCPostReplyModel *response;
@end
