//
//  MessageSSModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageSSModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *avatar;
@property (nonatomic, copy)NSString<Optional> *content;
@property (nonatomic, copy)NSString<Optional> *fromuid;
@property (nonatomic, copy)NSString<Optional> *HASH;
@property (nonatomic, copy)NSString<Optional> *is_zh;
@property (nonatomic, copy)NSString<Optional> *isfirstmsg;
@property (nonatomic, copy)NSString<Optional> *isread;
@property (nonatomic, copy)NSString<Optional> *kfname;
@property (nonatomic, copy)NSString<Optional> *mj;
@property (nonatomic, copy)NSString<Optional> *msg_type;
@property (nonatomic, copy)NSString<Optional> *msgid;
@property (nonatomic, copy)NSString<Optional> *redtime;
@property (nonatomic, copy)NSString<Optional> *replystatus;
@property (nonatomic, copy)NSString<Optional> *sendtime;
@property (nonatomic, copy)NSString<Optional> *touid;
@property (nonatomic, copy)NSString<Optional> *user_type;
@property (nonatomic, copy)NSString<Optional> *voice_time;

@end
