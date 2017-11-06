//
//  PPSSCashierEditViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSCashierModel.h"
@interface PPSSCashierEditViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger editType;
- (void)editCashierEvent:(PPSSCashierModel *)model;
@end
