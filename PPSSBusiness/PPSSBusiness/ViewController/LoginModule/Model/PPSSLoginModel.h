//
//  PPSSLoginModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSBannerModel : NSObject
@property (nonatomic, copy) NSString *bannerId;//
@property (nonatomic, copy) NSString *title;//
@property (nonatomic, copy) NSString *image;//
@property (nonatomic, copy) NSString *link;//
@end
@interface PPSSLoginModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *token;//token
@property (nonatomic, copy) NSString *power;//权限1店长2店员
@property (nonatomic, copy) NSString *username;//用户名
@property (nonatomic, copy) NSString *phone;//手机号码
@property (nonatomic, copy) NSString *userId;//用户ID
@property (nonatomic, copy) NSString *qcode;//二维码
@property (nonatomic, copy) NSString *incomeMoney;//当天收入金额
@property (nonatomic, copy) NSString *incomeNumber;//当天收入笔数
@property (nonatomic, copy) NSString *members;//当天新增会员
@property (nonatomic, copy) NSString *shopName;//二维码
@property (nonatomic, strong) NSArray *banners;//广告
@end
