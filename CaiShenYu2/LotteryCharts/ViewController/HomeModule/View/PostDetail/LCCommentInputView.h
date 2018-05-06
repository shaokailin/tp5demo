//
//  LCCommentInputView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKSTextView.h"
typedef void (^InputSendBlock) (NSString *text);
@interface LCCommentInputView : UIView<UITextFieldDelegate>
@property (nonatomic, assign) CGFloat StatusNav_Height;
@property (nonatomic, copy) InputSendBlock sendBlock;
@property (nonatomic, weak) DKSTextView *inputField;
@property (nonatomic, copy) NSString *placeholdString;
- (void)cleanText;
@end
