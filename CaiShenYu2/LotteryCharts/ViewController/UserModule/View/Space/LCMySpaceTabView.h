//
//  LCMySpaceTabView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SpaceTabBarBlock)(NSInteger type);
@interface LCMySpaceTabView : UIView
@property (nonatomic, copy) SpaceTabBarBlock tabbarBlock;
@end
