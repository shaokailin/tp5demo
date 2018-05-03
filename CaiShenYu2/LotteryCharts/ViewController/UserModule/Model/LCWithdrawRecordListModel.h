//
//  LCWithdrawRecordListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCWithdrawRecordModel : NSObject
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *status;     //1  等待审核  2 提现失败  3  提现成功
@property (nonatomic, copy) NSString *create_time;
@end
@interface LCWithdrawRecordListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
