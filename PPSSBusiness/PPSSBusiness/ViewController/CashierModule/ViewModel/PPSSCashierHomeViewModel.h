//
//  PPSSCashierHomeViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSLoginModel.h"
@interface PPSSCashierHomeViewModel : LSKBaseViewModel
@property (nonatomic, assign, readonly) BOOL isPull;
@property (nonatomic, strong) PPSSLoginModel *userMessageModel;
- (void)getUserMessageByToken:(BOOL)isPull;
@end
