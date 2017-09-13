//
//  JInModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/11.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JInModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *gold;

@property (nonatomic, copy)NSString<Optional> *ID;

@property (nonatomic, copy)NSString<Optional> *money;
@property (nonatomic, copy)NSString<Optional> *time;
@property (nonatomic, copy)NSString<Optional> *zmoney;
@end
