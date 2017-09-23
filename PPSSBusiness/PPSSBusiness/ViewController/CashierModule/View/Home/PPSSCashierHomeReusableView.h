//
//  PPSSCashierHomeReusableView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CashierHomeHeaderEventType) {
    CashierHomeHeaderEventType_CollectMoney,
    CashierHomeHeaderEventType_SaoYiSao
};

typedef void (^CashierHomeHeaderBlock)(CashierHomeHeaderEventType type);
static NSString * const kPPSSCashierHomeReusableView = @"PPSSCashierHomeReusableView";
@interface PPSSCashierHomeReusableView : UICollectionReusableView
@property (nonatomic, copy) CashierHomeHeaderBlock headerBlock;

/**
 设置内容

 @param money 收款金额
 @param count 收款单数
 @param member 新添加的会员数
 */
- (void)setupCashierContentWithMoney:(NSString *)money count:(NSString *)count addMember:(NSString *)member;
@end
