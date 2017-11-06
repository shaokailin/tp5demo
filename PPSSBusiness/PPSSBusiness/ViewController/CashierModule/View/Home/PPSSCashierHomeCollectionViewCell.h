//
//  PPSSCashierHomeCollectionViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPPSSCashierHomeCollectionViewCell = @"PPSSCashierHomeCollectionViewCell";
@interface PPSSCashierHomeCollectionViewCell : UICollectionViewCell
- (void)setupCellContentWithTitle:(NSString *)title
                      detailTitle:(NSString *)detailTitle
                             icon:(NSString *)icon;
@end
