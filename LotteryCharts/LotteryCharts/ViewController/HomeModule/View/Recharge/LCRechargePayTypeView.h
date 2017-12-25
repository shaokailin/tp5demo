//
//  LCRechargePayTypeView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PayTypeBlock)(NSInteger type);
@interface LCRechargePayTypeView : UIView
@property (nonatomic, copy) PayTypeBlock typeBlock;
@property (nonatomic, assign) NSInteger payType;
@end
