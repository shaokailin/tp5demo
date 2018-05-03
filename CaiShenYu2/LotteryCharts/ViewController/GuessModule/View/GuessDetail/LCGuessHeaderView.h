//
//  LCGuessHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCGuessModel;
typedef void (^HeaderBlock)(NSInteger type);
typedef void (^HeaderFrameBlock)(CGFloat height);
@interface LCGuessHeaderView : UIView<UITextFieldDelegate>
@property (nonatomic, copy) HeaderBlock hederBlock;
@property (nonatomic, copy) HeaderFrameBlock frameBlock;
@property (nonatomic, assign) BOOL isBecome;
@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UIButton *canyuBtn;

@property (copy, nonatomic) void(^myBlock)(UIButton *sender);

- (void)setupContentTitle:(NSString *)title money:(NSString *)money count:(NSInteger)count number1:(NSString *)number1 number2:(NSString *)number2 type:(NSInteger)type model:(LCGuessModel *)model;
- (void)setupContentWithContent:(NSString *)content height:(CGFloat)height;
- (void)hidenEventViewWithAuthor:(BOOL)isAuthor;
- (void)changeCount:(NSInteger)count;
@end
