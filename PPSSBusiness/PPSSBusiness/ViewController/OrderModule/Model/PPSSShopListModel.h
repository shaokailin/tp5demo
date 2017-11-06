//
//  PPSSShopListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSShopModel :NSObject
@property (nonatomic, copy) NSString *shopId;//商铺id
@property (nonatomic, copy) NSString *shopName;//商铺名称
@end

@interface PPSSShopListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@end
