//
//  PPSSIncomeViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSIncomeModel.h"
@interface PPSSIncomeViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *timeDate;
@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, strong) PPSSIncomeModel *incomeModel;
- (void)getShopIncomeEvent:(BOOL)isPull;

@property (nonatomic, strong) NSArray *shopListArray;
- (BOOL)getShopList;
@end
