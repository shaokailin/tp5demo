//
//  LCCantactListModel.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface LCCantactModel : NSObject
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *weixin;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *remark;
@end
@interface LCCantactListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *response;
@end
