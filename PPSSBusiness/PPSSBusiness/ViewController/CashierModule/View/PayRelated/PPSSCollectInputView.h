//
//  PPSSCollectInputView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPSSCollectInputView : UIView<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *allMoneyField;
@property (nonatomic, weak) UITextField *discountField;
@property (nonatomic, assign) NSInteger currentType;
@end
