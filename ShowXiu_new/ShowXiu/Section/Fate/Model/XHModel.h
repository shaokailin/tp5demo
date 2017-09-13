//
//  XHModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/7.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XHModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;

///图片
@property (nonatomic, copy)NSString<Optional> *avatar;

///名字
@property (nonatomic, copy)NSString<Optional> *user_nicename;
//赞数
@property (nonatomic, copy)NSString<Optional> *zan;

@end
