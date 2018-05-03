//
//  LCPostDetailMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCHomePostModel.h"
@interface LCPostDetailMessageModel : LSKBaseResponseModel
@property (nonatomic, strong) LCHomePostModel *response;
@end
