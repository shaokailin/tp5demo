//
//  LCTaskModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCTaskModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *all_money;
@property (nonatomic, copy) NSString *fish_ing;
@property (nonatomic, assign)  NSInteger is_sign;
@property (nonatomic, assign) NSInteger all_sign;
@property (nonatomic, assign) NSInteger is_share;
@property (nonatomic, assign) NSInteger today_post;
@end
