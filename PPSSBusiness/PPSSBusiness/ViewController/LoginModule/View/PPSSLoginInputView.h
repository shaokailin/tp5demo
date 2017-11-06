//
//  PPSSLoginInputView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LoginInputType) {
    LoginInputType_Account,
    LoginInputType_Password
};
@interface PPSSLoginInputView : UITextField<UITextFieldDelegate>
@property (nonatomic, strong) RACSignal *textSignal;
/**
 初始化输入框

 @param iconImage 图片
 @param placeholder 默认内容
 @return 输入框
 */
- (instancetype)initInputViewWithType:(LoginInputType)type icon:(NSString *)iconImage placeholder:(NSString *)placeholder;
@end
