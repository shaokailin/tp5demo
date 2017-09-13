//
//  MyChongModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/21.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyChongModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *ID;
@property (nonatomic, copy)NSString<Optional> *day;
@property (nonatomic, copy)NSString<Optional> *original;
@property (nonatomic, copy)NSString<Optional> *price;
@property (nonatomic, copy)NSString<Optional> *time;
@property (nonatomic, copy)NSString<Optional> *zk;
@end
