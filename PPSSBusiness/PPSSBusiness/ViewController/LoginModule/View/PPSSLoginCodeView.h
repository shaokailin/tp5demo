//
//  PPSSLoginCodeView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LoginCodeType) {
    LoginCodeType_Login,
    LoginCodeType_Forget
};
typedef void (^VerifiCodeBlock) (BOOL code);
@interface PPSSLoginCodeView : UITextField<UITextFieldDelegate>
- (instancetype)initWithType:(LoginCodeType)type block:(VerifiCodeBlock)block;

@end
