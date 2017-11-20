//
//  LCForgetPWDView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ForgetPwdBlock) (NSInteger type);
@interface LCForgetPWDView : UIView
@property (nonatomic, copy) ForgetPwdBlock forgetBlock;
@end
