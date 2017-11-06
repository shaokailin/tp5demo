//
//  PPSSMemberHomeViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSMemberHomeViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *memberListArray;
- (void)getMemberList:(BOOL)isPull;
@end
