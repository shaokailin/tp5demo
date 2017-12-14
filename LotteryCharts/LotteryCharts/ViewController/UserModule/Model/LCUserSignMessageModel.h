//
//  LCUserSignMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCUserSignModel : NSObject
@property (nonatomic, copy) NSString *sign_time;
@property (nonatomic, assign) NSInteger week;
@end
@interface LCUserSignMessageModel : LSKBaseResponseModel
@property (nonatomic, assign) NSInteger today_issign;
@property (nonatomic, assign) NSInteger zhou_sign;
@property (nonatomic, assign) NSInteger my_count;
@property (nonatomic, strong) NSArray *list_sign;
@end
