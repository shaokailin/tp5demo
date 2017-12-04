//
//  LCPostModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCPostModel : NSObject
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_type;
@property (nonatomic, copy) NSString *post_money;
@property (nonatomic, copy) NSString *post_vipmoney;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *reply_count;
@property (nonatomic, copy) NSString *reward_count;
@end
