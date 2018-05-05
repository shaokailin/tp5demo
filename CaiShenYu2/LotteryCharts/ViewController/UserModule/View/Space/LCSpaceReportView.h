//
//  LCSpaceReportView.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/5.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SureBlock)(NSString *postId,NSString *report);
@interface LCSpaceReportView : UIView
@property (nonatomic, copy) SureBlock block;
@end
