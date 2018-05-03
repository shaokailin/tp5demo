//
//  LCRegisterMainView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RegisterMainBlock)(NSInteger type);
@interface LCRegisterMainView : UIView
@property (nonatomic, copy) RegisterMainBlock registerBlock;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *inviteField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@end
