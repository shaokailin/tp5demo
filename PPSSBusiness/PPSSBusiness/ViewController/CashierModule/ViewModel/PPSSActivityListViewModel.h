//
//  PPSSActivityListViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
@interface PPSSActivityListViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSMutableArray *activityListArray;
@property (nonatomic, readonly, assign) BOOL isSuccess;
- (void)getActivityList:(BOOL)isPull;
@end
