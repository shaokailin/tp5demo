//
//  PPSSCashierHomeFooterReusableView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/27.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSCashierHomeFooterReusableView = @"PPSSCashierHomeFooterReusableView";
typedef void (^BannerClickBlock)(NSInteger index);
typedef void (^BtnClickBlock)(NSInteger type);
@interface PPSSCashierHomeFooterReusableView : UICollectionReusableView
@property (nonatomic, copy) BannerClickBlock clickBlock;
@property (nonatomic, copy) BtnClickBlock btnBlock;
- (void)showSettingView:(BOOL)isShow;
/**
 设置内容
 
 @param money 收款金额
 @param count 收款单数
 @param member 新添加的会员数
 */
- (void)setupCashierContentWithMoney:(NSString *)money count:(NSString *)count addMember:(NSString *)member;

- (void)setupBannersImageArray:(NSArray *)array;
- (void)viewDidDisAppearForBanner;
- (void)viewDidAppearForBanner;
@end
