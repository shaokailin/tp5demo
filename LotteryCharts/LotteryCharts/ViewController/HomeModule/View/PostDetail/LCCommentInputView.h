//
//  LCCommentInputView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^InputSendBlock) (NSString *text);
@interface LCCommentInputView : UIView<UITextFieldDelegate>

@property (nonatomic, copy) InputSendBlock sendBlock;
@property (nonatomic, weak) UITextField *inputField;
- (void)cleanText;
@end
