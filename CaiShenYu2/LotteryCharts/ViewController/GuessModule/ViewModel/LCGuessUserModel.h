//
//  LCGuessUserModel.h
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCUserModuleAPI.h"
#import "LSKBaseViewModel.h"

@interface LCGuessUserModel : LSKBaseViewModel

@property (nonatomic, copy) NSString *quiz_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *attentionArray;
- (void)getUserAttentionList:(BOOL)isPull;
@end
