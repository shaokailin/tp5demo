//
//  LCLoginMainView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginActionBlock)(NSInteger type);//1.返回、2忘记密码 3.登录 4.注册 5，微信 6.qq
@interface LCLoginMainView : UIView
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, copy) LoginActionBlock loginBlock;
@end
