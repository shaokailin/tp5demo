//
//  HSPActionSheetView.h
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LSKActionSheetBlock) (NSInteger seletedIndex);//0是取消
@interface LSKActionSheetView : UIView
- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle clcikIndex:(LSKActionSheetBlock)seletedBlock otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)showInView;
@end
