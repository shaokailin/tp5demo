//
//  EvaluationModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/20.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EvaluationModel : JSONModel
///用户的头像
@property (nonatomic, copy)NSString<Optional> *avatar;
///用户的id
@property (nonatomic, copy)NSString *uid;
///内容
@property (nonatomic, copy)NSString *content;
///评论时间
@property (nonatomic, copy)NSString *time;
///VIP 1是 2否
@property (nonatomic, copy)NSString *user_rank;
///赞数
@property (nonatomic, copy)NSString *zan;
///用户的名字
@property (nonatomic, copy)NSString *user_nicename;
///审核数
@property (nonatomic, copy)NSString *flag;
///评论的ID
@property (nonatomic, copy)NSString *ID;
@end
