//
//  PPSSActivityListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSActivityListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;//活动数据
@property (nonatomic, assign) NSInteger totalPage;//总数据
@end
