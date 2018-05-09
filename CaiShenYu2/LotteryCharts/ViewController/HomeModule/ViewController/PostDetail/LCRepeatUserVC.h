//
//  LCRepeatUserVC.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/6.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
@class LCPostReplyModel;
@interface LCRepeatUserVC : LSKBaseViewController
@property (nonatomic, copy) NSString *postId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) LCPostReplyModel *model;
@end
