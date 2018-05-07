//
//  LCUserMessageListModel.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCUserNoticeModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *extends;
@property (nonatomic, copy) NSString *noticeId;
@property (nonatomic, copy) NSString *is_read;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDictionary *userMessage;
@property (nonatomic, assign) CGFloat height;
@end
@interface LCUserMessageListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
