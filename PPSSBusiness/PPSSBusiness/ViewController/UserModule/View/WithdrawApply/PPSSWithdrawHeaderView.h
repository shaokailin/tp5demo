//
//  PPSSWithdrawHeaderView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WithdrawHeaderBlock)(NSString *money);
@interface PPSSWithdrawHeaderView : UIView
@property (nonatomic, copy) WithdrawHeaderBlock withdrawBlock;
- (void)setupMoneyViewWithBalance:(NSString *)balance share:(NSString *)share;
@end
