//
//  LCUserSignViewModel.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCUserSignMessageModel.h"
@interface LCUserSignViewModel : LSKBaseViewModel
@property (nonatomic, strong) LCUserSignMessageModel *messageModel;
- (void)userSignClickEvent;
- (void)getSignMessage;
@end
