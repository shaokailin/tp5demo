//
//  FocusModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FocusModel : JSONModel
///用户id
@property (nonatomic, copy)NSString<Optional> *ID;
///图片
@property (nonatomic, copy)NSString<Optional> *avatar;
///名字
@property (nonatomic, copy)NSString *user_nicename;
///
@property (nonatomic, copy)NSString *time;
///
@property (nonatomic, copy)NSString *user_rank;

@property (nonatomic, copy)NSString *idmd5;


@end
