//
//  RecommeModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RecommeModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;
///出生年月
@property (nonatomic, copy)NSString *age;
///图片
@property (nonatomic, copy)NSString<Optional> *avatar;
///名字
@property (nonatomic, copy)NSString *user_nicename;
///
@property (nonatomic, copy)NSString *sex;
///
@property (nonatomic, copy)NSString *ismj;

@property (nonatomic, copy)NSString *km;
@property (nonatomic, copy)NSString *provinceid;
@property (nonatomic, copy)NSString *cityid;
@property (nonatomic, copy)NSString *dzh;


@end
