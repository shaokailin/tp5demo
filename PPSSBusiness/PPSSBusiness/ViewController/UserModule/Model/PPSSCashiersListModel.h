//
//  PPSSCashiersListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSCashiersListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger totalPage;
@end
