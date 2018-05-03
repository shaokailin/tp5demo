//
//  LCUserMessageViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCUserMessageViewModel : LSKBaseViewModel
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign) NSInteger sexString;
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *mchnoString;
@property (nonatomic, copy) NSString *birthday;

- (void)updateUserMessage;
@end
