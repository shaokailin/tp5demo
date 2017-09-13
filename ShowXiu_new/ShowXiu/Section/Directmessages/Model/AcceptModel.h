//
//  AcceptModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AcceptModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *avatar;
@property (nonatomic, copy)NSString<Optional> *user_nicename;
@property (nonatomic, copy)NSString<Optional> *fromuid;
@property (nonatomic, copy)NSString<Optional> *yuejian;
@property (nonatomic, copy)NSString<Optional> *gift_price;
@property (nonatomic, copy)NSString<Optional> *giftnum;
@property (nonatomic, copy)NSString<Optional> *gift_image;
@property (nonatomic, copy)NSString<Optional> *touser_isread;
@property (nonatomic, copy)NSString<Optional> *giftlist_id;
@property (nonatomic, copy)NSString<Optional> *time;
@property (nonatomic, copy)NSString<Optional> *user_rank;
@property (nonatomic, copy)NSString<Optional> *ID;
@end
