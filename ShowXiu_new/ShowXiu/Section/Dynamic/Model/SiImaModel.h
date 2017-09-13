//
//  SiImaModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SiImaModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *hits;
@property (nonatomic, copy)NSString<Optional> *mp4;
@property (nonatomic, copy)NSString<Optional> *photoid;
@property (nonatomic, copy)NSString<Optional> *see_status;
@property (nonatomic, copy)NSString<Optional> *uploadfiles;
@property (nonatomic, copy)NSString<Optional> *view;

@end
