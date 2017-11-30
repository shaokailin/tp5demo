//
//  LCUserMianViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCUserHomeMessageModel.h"
@interface LCUserMianViewModel : LSKBaseViewModel
@property (nonatomic, strong) LCUserHomeMessageModel *messageModel;
- (void)getUserMessage;
- (void)userSignClickEvent;
- (void)loginOutClickEvent;
@property (nonatomic, strong) UIImage *photoImage;
- (void)updateUserPhoto;
@end
