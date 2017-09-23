//
//  PPSSActivityDetailVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef NS_ENUM(NSInteger,ActivityDetailType) {
    ActivityDetailType_Add,
    ActivityDetailType_Exit
};
@interface PPSSActivityDetailVC : LSKBaseViewController
@property (nonatomic, assign) ActivityDetailType type;
@property (nonatomic, assign) NSInteger activityType;
@property (nonatomic, copy) NSString *activityTitle;
@end
