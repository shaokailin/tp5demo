//
//  LCHistoryOrderListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCHistoryOrderModel : NSObject
@property (nonatomic, copy) NSString *award_money;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_type;
@property (nonatomic, copy) NSString *post_money;
@property (nonatomic, copy) NSString *post_vipmoney;
@property (nonatomic, copy) NSString *reward_money;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mch_no;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@end
@interface LCHistoryOrderListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
