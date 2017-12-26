//
//  LCGuessModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCGuessReplyModel.h"
@interface LCGuessModel : NSObject
@property (nonatomic, copy) NSString *quiz_id;
@property (nonatomic, copy) NSString *post_common_id;
@property (nonatomic, copy) NSString *period_id;
@property (nonatomic, copy) NSString *quiz_title;
@property (nonatomic, copy) NSString *quiz_content;
@property (nonatomic, assign) NSInteger quiz_type;
@property (nonatomic, copy) NSString *quiz_answer;
@property (nonatomic, copy) NSString *quiz_money;
@property (nonatomic, assign) NSInteger quiz_number;
@property (nonatomic, assign) NSInteger quiz_buynumber;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, strong) NSArray *reply;
@property (nonatomic, copy) NSString *mch_no;
@property (nonatomic, assign) NSInteger hasCount;
@property (nonatomic, assign) CGFloat contentHeight;
@end
