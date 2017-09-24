//
//  PPSSCollectMoneyVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef NS_ENUM(NSInteger, CollectMoneyInType){
    CollectMoneyInType_Input,
    CollectMoneyInType_SaoYiSao
};
@interface PPSSCollectMoneyVC : LSKBaseViewController
@property (nonatomic, assign) CollectMoneyInType inType;
@end
