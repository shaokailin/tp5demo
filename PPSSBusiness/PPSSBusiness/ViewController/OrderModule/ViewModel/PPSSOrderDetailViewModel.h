//
//  PPSSOrderDetailViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSOrderDetailModel.h"
@interface PPSSOrderDetailViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, strong) PPSSOrderDetailModel *orderDetailModel;
- (void)getOrderDetail;
@end
