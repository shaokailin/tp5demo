//
//  LCHomeHeaderMessageModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseResponseModel.h"
#import "LCAdBannerModel.h"
#import "LCHomeNoticeModel.h"
#import "LC3DLotteryModel.h"
@interface LCHomeHeaderMessageModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *adv_list;
@property (nonatomic, strong) NSArray *notice;
@property (nonatomic, strong) NSArray *period_list;
@end
