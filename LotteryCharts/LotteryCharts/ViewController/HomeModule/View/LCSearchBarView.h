//
//  LCSearchBarView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SearchViewBlock)(NSInteger type);//1.显示目录，2.搜索
@interface LCSearchBarView : UIView
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, copy) SearchViewBlock searchBlock;
@property (nonatomic, assign) NSInteger currentSearchType;//0:标题 1.码师id 2.帖子
@end
