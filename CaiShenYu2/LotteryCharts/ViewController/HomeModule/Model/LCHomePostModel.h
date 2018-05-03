//
//  LCHomePostModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCHomePostModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *fans_count;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_content;
@property (nonatomic, copy) NSString *post_upload;
@property (nonatomic, copy) NSString *post_type;
@property (nonatomic, copy) NSString *post_money;
@property (nonatomic, copy) NSString *post_vipmoney;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *mch_no;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, copy) NSString *reward_count;
@property (nonatomic, copy) NSString *reward_money;
@property (nonatomic, copy) NSString *make_click;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@end
