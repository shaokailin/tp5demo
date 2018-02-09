//
//  LCPayResultHandle.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/2/9.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
@protocol PayResultDelegate <NSObject>
@optional
- (void)wxPayResultCallBlack:(BOOL)isSuccess;
@end
@interface LCPayResultHandle : NSObject<WXApiDelegate>
@property (nonatomic, assign) id<PayResultDelegate> delegate;
+ (instancetype)sharedManager;

@end
