//
//  MyImageViewModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyImageViewModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *photoid;

@property (nonatomic, copy)NSString<Optional> *uid;

@property (nonatomic, copy)NSString<Optional> *title;

@property (nonatomic, copy)NSString<Optional> *uploadfiles;
@property (nonatomic, copy)NSString<Optional> *thumbfiles;
@property (nonatomic, copy)NSString<Optional> *timeline;
@property (nonatomic, copy)NSString<Optional> *flag;
@property (nonatomic, copy)NSString<Optional> *elite;
@property (nonatomic, copy)NSString<Optional> *istop;
@property (nonatomic, copy)NSString<Optional> *hits;
@property (nonatomic, copy)NSString<Optional> *phototype;
@property (nonatomic, copy)NSString<Optional> *intro;
@property (nonatomic, copy)NSString<Optional> *auditremark;
@property (nonatomic, copy)NSString<Optional> *payMoney;
@property (nonatomic, copy)NSString<Optional> *isavatr;
@property (nonatomic, copy)NSString<Optional> *idmd5;
@property (nonatomic, copy)NSString<Optional> *user_nicename;
@property (nonatomic, copy)NSString<Optional> *avatar;
@end
