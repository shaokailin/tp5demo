//
//  PPSSMemberListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSMemberModel : NSObject
@property (nonatomic, copy) NSString *userId;//会员id
@property (nonatomic, copy) NSString *userName;//会员名称
@property (nonatomic, copy) NSString *userPhone;//会员手机号码
@property (nonatomic, copy) NSString *userTimes;//消费次数
@property (nonatomic, copy) NSString *feeTotal;//消费总额
@property (nonatomic, copy) NSString *userStore;//储值
@property (nonatomic, copy) NSString *userAvatar;//头像
@end
@interface PPSSMemberListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@end
