//
//  LCWithdrawRecordHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SearchEventBlock)(NSInteger type,UIImageView *image);
@interface LCWithdrawRecordHeaderView : UIView
@property (nonatomic, copy) SearchEventBlock searchBlock;
- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right;
@end
