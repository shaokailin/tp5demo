//
//  PPSSActivityDetailViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSActivityModel.h"
@interface PPSSActivityDetailViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger editType;
@property (nonatomic, assign) NSInteger activityType;
- (void)editActivityEvent:(PPSSActivityModel *)model;

@property (nonatomic, strong) NSArray *shopListArray;
- (BOOL)getShopList;
@end
