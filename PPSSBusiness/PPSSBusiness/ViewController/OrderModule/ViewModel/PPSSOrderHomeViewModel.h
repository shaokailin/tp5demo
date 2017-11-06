//
//  PPSSOrderHomeViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSOrderHomeViewModel : LSKBaseViewModel
@property (nonatomic, strong) NSArray *shopListArray;
- (BOOL)getShopList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, strong) NSMutableArray *orderListArray;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, assign) NSInteger payStatus;
- (void)getOrderList:(BOOL)isPull;

@end
