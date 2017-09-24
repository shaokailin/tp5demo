//
//  PPSSCollectKeyboardView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CollectMoneyBlock) (NSString *title);
@interface PPSSCollectKeyboardView : UIView
@property (nonatomic, copy) NSString *inputStr;
@property (nonatomic, copy) CollectMoneyBlock collectBlock;
- (instancetype)initWithBtnWidth:(CGFloat)width betweenWidth:(CGFloat)betweenWidth;
- (NSString *)changeInputType:(NSString *)title;
@end
