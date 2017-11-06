//
//  PPSSMemberDetailModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSMemberDetailModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *userId;//会员id
@property (nonatomic, copy) NSString *userName;//会员名称
@property (nonatomic, copy) NSString *userPhone;//会员手机号码
@property (nonatomic, copy) NSString *userTimes;//消费次数
@property (nonatomic, copy) NSString *userScore;//积分
@property (nonatomic, copy) NSString *userStore;//储值
@property (nonatomic, copy) NSString *userAvatar;//头像
@property (nonatomic, copy) NSString *feeAverage;//平均消费（元)
@property (nonatomic, copy) NSString *feeTotal;//累计消费（元)
@property (nonatomic, copy) NSString *LastTime;//最后消费时间
@property (nonatomic, copy) NSString *createTime;//成为会员时间
@property (nonatomic, copy) NSString *userBirth;//生日
@property (nonatomic, copy) NSString *userArea;//地区
@property (nonatomic, copy) NSString *remark;//备注
@end
