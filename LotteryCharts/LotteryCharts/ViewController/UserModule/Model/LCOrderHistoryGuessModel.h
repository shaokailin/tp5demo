//
//  LCOrderHistoryGuessModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/26.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCHistoryGuessModel : NSObject
@property (nonatomic, copy) NSString *betting_num;
@property (nonatomic, assign) NSInteger quiz_type;
@property (nonatomic, copy) NSString *quiz_id;
@property (nonatomic, copy) NSString *quiz_answer;
@property (nonatomic, copy) NSString *quiz_buynumber;
@property (nonatomic, copy) NSString *quiz_money;
@property (nonatomic, copy) NSString *quiz_number;
@property (nonatomic, copy) NSString *quiz_title;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mch_no;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, assign) NSInteger status;
@end
@interface LCOrderHistoryGuessModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
