//
//  LCPostDetailModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailModel.h"

@implementation LCPostDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"reply_list" : [LCPostReplyModel class],
             };
}
- (void)setCreate_time:(NSString *)create_time {
    if (KJudgeIsNullData(create_time)) {
        NSString *endFormar = @"yyyy年MM月dd日  HH:mm";
        _create_time = [[NSDate dateWithTimeIntervalSince1970:[create_time integerValue]]dateTransformToString:endFormar];
    }
    _create_time = nil;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"reply_list" : @"response.reply_list",
             @"post_title" : @"response.post_title",
             @"post_content" : @"response.post_content",
             @"post_upload" : @"response.post_upload",
             @"post_type" : @"response.post_type",
             @"post_money" : @"response.post_money",
             @"post_vipmoney" : @"response.post_vipmoney",
             @"user_id" : @"response.user_id",
             @"status" : @"response.status",
             @"create_time" : @"response.create_time",
             @"return_status" : @"response.return_status",
             @"post_id" : @"response.post_id",
             @"is_follow" : @"response.is_follow",
             @"reply_count" : @"response.reply_count",
             @"reward_count" : @"response.reward_count",
             @"reward_money" : @"response.reward_money",
             };
}
@end
