//
//  PPSSComplaintAdviceVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/9.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef NS_ENUM(NSInteger, InControllerType) {
    InControllerType_Complaint,
    InControllerType_Remark
};
typedef void (^RemarkChangeBlock)(NSString *remark);
@interface PPSSComplaintAdviceVC : LSKBaseViewController
@property (nonatomic, assign) InControllerType type;
@property (nonatomic, copy) NSString *remarkText;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) RemarkChangeBlock remarkBlock;
@end
