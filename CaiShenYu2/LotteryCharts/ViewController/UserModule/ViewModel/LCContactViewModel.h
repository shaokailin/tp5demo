//
//  LCContactViewModel.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCCantactListModel.h"
@interface LCContactViewModel : LSKBaseViewModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *contactArray;
- (void)getContactList:(BOOL)isPull;
@end
