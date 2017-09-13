//
//  DYFindModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/18.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DYFindModel : JSONModel
///用户的头像
@property (nonatomic, copy)NSString *avatar;
///用户的id
@property (nonatomic, copy)NSString<Optional> *uid;
///内容
@property (nonatomic, copy)NSString<Optional> *title;
///发布时间戳
@property (nonatomic, copy)NSString<Optional> *timeline;
///VIP 1是 2否
@property (nonatomic, copy)NSString<Optional> *user_rank;
///用户IDmd5
@property (nonatomic, copy)NSString<Optional> *hits;
///图片数组
@property (nonatomic, strong)NSArray<Optional> *thumbfiles;
///用户的名字
@property (nonatomic, copy)NSString<Optional> *user_nicename;
///评论数组
@property (nonatomic, strong)NSArray<Optional> *comment;
///性别
@property (nonatomic, copy)NSString<Optional> *sex;
///年龄
@property (nonatomic, copy)NSString<Optional> *age;
///cell高度
@property (nonatomic, copy)NSString<Optional> *cellHH;
///页眉的高度
@property (nonatomic, copy)NSString<Optional> *ViewHH;
///图片H
@property (nonatomic, copy)NSString<Optional> *imagHH;
///图片W
@property (nonatomic, copy)NSString<Optional> *imagWW;



+ (DYFindModel *)modelWithDict:(NSDictionary *)dict;




@end
