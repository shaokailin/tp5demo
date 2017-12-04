//
//  LCSpacePostListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCUserMessageModel.h"
#import "LCPostModel.h"
@interface LCSpacePostListModel : LSKBaseResponseModel
@property (nonatomic, strong) LCUserMessageModel *user_info;
@property (nonatomic, copy) NSString *follow_count;
@property (nonatomic, copy) NSString *team_count;
@property (nonatomic, strong) NSArray *post_list;
@end
