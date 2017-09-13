//
//  MyFenModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/9.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyFenModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *ID;

@property (nonatomic, copy)NSString<Optional> *time;

@property (nonatomic, copy)NSString<Optional> *user_nicename;

@property (nonatomic, copy)NSString<Optional> *avatar;
@property (nonatomic, copy)NSString<Optional> *sex;
@property (nonatomic, copy)NSString<Optional> *age;
@property (nonatomic, copy)NSString<Optional> *jifen;
@property (nonatomic, copy)NSString<Optional> *user_rank;
@property (nonatomic, copy)NSString<Optional> *rank_time;
@property (nonatomic, copy)NSString<Optional> *provinceid;
@property (nonatomic, copy)NSString<Optional> *cityid;
@property (nonatomic, copy)NSString<Optional> *monolog;
@property (nonatomic, copy)NSString<Optional> *astro;
@property (nonatomic, copy)NSString<Optional> *idmd5;
@property (nonatomic, copy)NSString<Optional> *city_name;
@end
