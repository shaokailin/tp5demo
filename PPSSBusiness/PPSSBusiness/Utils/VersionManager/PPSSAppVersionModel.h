//
//  PPSSAppVersionModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface PPSSAppVersionModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *download;//APP下载路径
@property (nonatomic, copy) NSString *title;//app名称
@property (nonatomic, copy) NSString *version;//表示当前版本号
@property (nonatomic, copy) NSString *must;//1强制更新，2不强制更新
@property (nonatomic, copy) NSString *content;//对应版本内容
@property (nonatomic, copy) NSString *type;//平台类型
@end
