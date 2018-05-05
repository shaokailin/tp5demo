//
//  LCPublicNoticeVM.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCPublicNoticeVM : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *listArray;
- (void)getPublicData:(BOOL)isPull;
@end
