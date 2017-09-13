//
//  GiftModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GiftModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *gift_id;
@property (nonatomic, copy)NSString<Optional> *gift_name;
@property (nonatomic, copy)NSString<Optional> *images;
@property (nonatomic, copy)NSString<Optional> *price;
@property (nonatomic, copy)NSString<Optional> *rebate;
@property (nonatomic, copy)NSString<Optional> *jifen;
@property (nonatomic, copy)NSString<Optional> *create_time;
@property (nonatomic, copy)NSString<Optional> *status;
@property (nonatomic, copy)NSString<Optional> *desc;
@property (nonatomic, copy)NSString<Optional> *qmd;
@property (nonatomic, copy)NSString<Optional> *category_id;
@property (nonatomic, copy)NSString<Optional> *paixu;
@property (nonatomic, copy)NSString<Optional> *vip_price;

@end
