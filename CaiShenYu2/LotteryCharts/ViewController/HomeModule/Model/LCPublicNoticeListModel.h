//
//  LCPublicNoticeListModel.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCPublicNoticeModel : NSObject
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat height;
@end
@interface LCPublicNoticeListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end


