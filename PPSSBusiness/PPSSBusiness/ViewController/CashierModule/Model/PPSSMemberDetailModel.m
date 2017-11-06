//
//  PPSSMemberDetailModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberDetailModel.h"

@implementation PPSSMemberDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"userId" : @"data.userId",
             @"userName" : @"data.userName",
             @"userPhone" : @"data.userPhone",
             @"userTimes" : @"data.userTimes",
             @"userScore" : @"data.userScore",
             @"userStore" : @"data.userStore",
             @"userAvatar" : @"data.userAvatar",
             @"feeAverage" : @"data.feeAverage",
             @"feeTotal" : @"data.feeTotal",
             @"createTime" : @"data.createTime",
             @"LastTime" : @"data.LastTime",
             @"userBirth" : @"data.userBirth",
             @"userArea" : @"data.userArea",
             @"remark" : @"data.remark",
             };
}
- (void)setUserTimes:(NSString *)userTimes {
    _userTimes = KNullTransformNumber(userTimes);
}
- (void)setUserScore:(NSString *)userScore {
    _userScore = KNullTransformNumber(userScore);
}
- (void)setFeeAverage:(NSString *)feeAverage {
    _feeAverage = KNullTransformMoney(feeAverage);
}
- (void)setFeeTotal:(NSString *)feeTotal {
    _feeTotal = KNullTransformMoney(feeTotal);
}
@end
