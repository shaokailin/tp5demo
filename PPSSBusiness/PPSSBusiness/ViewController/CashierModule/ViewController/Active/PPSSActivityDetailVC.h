//
//  PPSSActivityDetailVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
#import "PPSSActivityModel.h"
typedef NS_ENUM(NSInteger,ActivityDetailType) {
    ActivityDetailType_Add = 1,
    ActivityDetailType_Exit = 2,
    ActivityDetailType_Delect = 3
};
typedef void (^ActivityEditBlock)(NSInteger editType,PPSSActivityModel *model);
@interface PPSSActivityDetailVC : LSKBaseViewController
@property (nonatomic, strong) PPSSActivityModel *activityModel;
@property (nonatomic, copy) ActivityEditBlock editBlock;
@property (nonatomic, assign) ActivityDetailType editType;
@end
