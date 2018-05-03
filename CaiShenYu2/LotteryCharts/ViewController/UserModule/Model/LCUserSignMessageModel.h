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
@property (nonatomic, assign) NSInteger today_sign;
@property (nonatomic, assign) NSInteger earn_sign_week;
@property (nonatomic, assign) NSInteger earn_sign_total;
@property (nonatomic, strong) NSMutableArray *this_week_sign_list;
@end
