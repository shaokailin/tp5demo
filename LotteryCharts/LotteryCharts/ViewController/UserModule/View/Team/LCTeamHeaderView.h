//
//  LCTeamHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TeamEventBlock)(NSInteger type);//0团队，1签dao 
@interface LCTeamHeaderView : UIView
@property (nonatomic, copy) TeamEventBlock teamBlock;
- (void)setupContentWithLineCount:(NSString *)line allCount:(NSString *)allCount;
@end
