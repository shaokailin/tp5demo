//
//  LCPostDetailVC.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
#import "LCHomePostModel.h"
@interface LCPostDetailVC : LSKBaseViewController
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) LCHomePostModel *postModel;
@end
