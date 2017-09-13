//
//  LiaoModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LiaoModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *age;

///图片
@property (nonatomic, copy)NSString<Optional> *avatar;
///用户id
@property (nonatomic, copy)NSString<Optional> *cityid;

///图片
@property (nonatomic, copy)NSString<Optional> *cityname;
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;

@property (nonatomic, copy)NSString<Optional> *sex;
///用户id
@property (nonatomic, copy)NSString<Optional> *user_nicename;
@end
