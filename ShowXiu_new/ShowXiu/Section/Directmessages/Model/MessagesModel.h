//
//  MessagesModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessagesModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *notice_id;
@property (nonatomic, copy)NSString<Optional> *uid;
@property (nonatomic, copy)NSString<Optional> *content;
@property (nonatomic, copy)NSString<Optional> *uptime;
@property (nonatomic, copy)NSString<Optional> *notice_type;
@property (nonatomic, copy)NSString<Optional> *msg_type;
@property (nonatomic, copy)NSString<Optional> *unread;
@property (nonatomic, copy)NSString<Optional> *avatar;
@property (nonatomic, copy)NSString<Optional> *user_nicename;
@property (nonatomic, copy)NSString<Optional> *user_rank;

@end
