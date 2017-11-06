//
//  PPSSNoticeListModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface PPSSNoticeModel : NSObject
@property (nonatomic, copy) NSString *noticeId;//消息id
@property (nonatomic, copy) NSString *time;//时间
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *address;//消息地址
@end
@interface PPSSNoticeListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@end
