//
//  PPSSIncomeHeaderView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PPSSIncomeHeaderView : UIView
@property (nonatomic, copy)OrderHomeSearchClickBlock clickBlock;
@property (nonatomic, readonly, copy) NSString *dateTime;
- (void)changeBtnText:(NSString *)text type:(OrderHomeSearchClickType)type;
@end
