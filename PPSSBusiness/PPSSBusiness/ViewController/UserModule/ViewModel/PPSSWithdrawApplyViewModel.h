//
//  PPSSWithdrawApplyViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSWithdrawListModel.h"
@interface PPSSWithdrawApplyViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *withdrawListArray;
@property (nonatomic, copy) NSString *totalMoney;
- (void)getWithdrawList:(BOOL)isPull;

@property (nonatomic, copy) NSString *withdrawMoney;
- (void)withdrawApplyEvent;
@end
