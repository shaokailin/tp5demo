//
//  LCPostReplyModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCPostReplyModel : NSObject
@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *create_time;
@end
