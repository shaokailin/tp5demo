//
//  LCSpacePostListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceModel.h"
#import "LCUserMessageModel.h"
#import "LCPostModel.h"
@interface LCSpacePostListModel : LCSpaceModel
@property (nonatomic, strong) LCUserMessageModel *user_info;
@property (nonatomic, copy) NSString *follow_count;
@property (nonatomic, copy) NSString *team_count;
@property (nonatomic, copy) NSString *post_list_count;
@property (nonatomic, copy) NSString *my_mchmoney;
@end
