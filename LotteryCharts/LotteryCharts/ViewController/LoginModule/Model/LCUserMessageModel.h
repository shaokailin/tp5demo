//
//  LCUserMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface LCUserMessageModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *mchid;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *ymoney;
@end
