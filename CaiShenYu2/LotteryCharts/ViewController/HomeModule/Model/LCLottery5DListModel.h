//
//  LCLottery5DListModel.h
//  LotteryCharts
//
//  Created by linshaokai on 2018/1/6.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCLottery5DModel : NSObject
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *p_name;
@property (nonatomic, copy) NSString *number1;
@property (nonatomic, copy) NSString *number2;
@property (nonatomic, copy) NSString *number3;
@property (nonatomic, copy) NSString *number4;
@property (nonatomic, copy) NSString *number5;
@end
@interface LCLottery5DListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
