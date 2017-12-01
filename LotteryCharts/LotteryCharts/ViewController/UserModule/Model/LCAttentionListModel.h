//
//  LCAttentionListModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCAttentionModel : NSObject
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *ymoney;
@property (nonatomic, copy) NSString *uid;
@end
@interface LCAttentionListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
