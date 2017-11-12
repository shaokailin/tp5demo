//
//  LCHomeFuncView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HomeFuncEnum) {
    HomeFuncEnum_Ranking = 0,
    HomeFuncEnum_Live,
    HomeFuncEnum_History,
    HomeFuncEnum_Pay
};
typedef void (^FuncViewBlock) (HomeFuncEnum type);
@interface LCHomeFuncView : UIView
@property (nonatomic, copy) FuncViewBlock funcBlock;
@end
