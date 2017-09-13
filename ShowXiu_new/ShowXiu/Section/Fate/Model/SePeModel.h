//
//  SePeModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/12.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SePeModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;

///图片
@property (nonatomic, copy)NSString<Optional> *user_login;
///用户id
@property (nonatomic, copy)NSString<Optional> *user_nicename;

///图片
@property (nonatomic, copy)NSString<Optional> *avatar;
///用户id
@property (nonatomic, copy)NSString<Optional> *user_rank;

@property (nonatomic, copy)NSString *monolog;
///用户id
@property (nonatomic, copy)NSString<Optional> *zan;


@end
