//
//  LCUserAttentionViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCAttentionListModel.h"
@interface LCUserAttentionViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *attentionArray;
- (void)getUserAttentionList:(BOOL)isPull;
- (void)getUserFansList:(BOOL)isPull;
@end
