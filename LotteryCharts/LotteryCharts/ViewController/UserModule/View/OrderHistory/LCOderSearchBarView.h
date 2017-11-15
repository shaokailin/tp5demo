//
//  LCOderSearchBarView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SearchEventBlock)(NSInteger type,id param);
@interface LCOderSearchBarView : UIView
@property (nonatomic, copy) SearchEventBlock searchBlock;
@property (nonatomic, copy) NSString *searchText;
- (void)setupContent:(NSString *)title;
@end
