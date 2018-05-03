//
//  UserListModel.h
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSKBaseResponseModel.h"

@interface GuessUserModel : NSObject
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mch_no;
@property (nonatomic, copy) NSString *betting_num;
@property (nonatomic, copy) NSString *quiz_money;
@end


@interface UserListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;

@end
