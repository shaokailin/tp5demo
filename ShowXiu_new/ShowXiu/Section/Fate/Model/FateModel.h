//
//  FateModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/21.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FateModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;

///图片
@property (nonatomic, copy)NSString<Optional> *avatar;

///名字
@property (nonatomic, copy)NSString<Optional> *user_nicename;
///年龄
@property (nonatomic, copy)NSString<Optional> *age;
///性别
@property (nonatomic, copy)NSString<Optional> *sex;
///打招呼
@property (nonatomic, copy)NSString<Optional> *dzh;
@end
