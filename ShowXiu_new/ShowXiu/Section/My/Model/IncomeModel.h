//
//  IncomeModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/10.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IncomeModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *money;

@property (nonatomic, copy)NSString<Optional> *time;

@property (nonatomic, copy)NSString<Optional> *desc;


@end
