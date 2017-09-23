//
//  PPSSPersonAssetView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPSSPersonAssetView : UIView

/**
 设置资产的内容

 @param balance 余额
 @param income 收入
 @param bankHasCash 银行已结算
 @param bankUnCash 银行待结算
 */
- (void)setupAssetWithBalance:(NSString *)balance income:(NSString *)income bankHasCash:(NSString *)bankHasCash bankUnCash:(NSString *)bankUnCash;
@end
