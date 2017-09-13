//
//  XiaoMessModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XiaoMessModel : JSONModel
@property (nonatomic, strong)NSDictionary<Optional> *content;
@property (nonatomic, copy)NSString<Optional> *fromuid;
@property (nonatomic, copy)NSString<Optional> *isread;
@property (nonatomic, copy)NSString<Optional> *miss_id;
@property (nonatomic, copy)NSString<Optional> *msg_type;
@property (nonatomic, copy)NSString<Optional> *sendtime;
@property (nonatomic, copy)NSString<Optional> *voice_time;
@property (nonatomic, copy)NSString<Optional> *touid;

@end
