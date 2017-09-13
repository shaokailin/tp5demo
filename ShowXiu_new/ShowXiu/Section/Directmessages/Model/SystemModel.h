//
//  SystemModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SystemModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *msg_content;
@property (nonatomic, copy)NSString<Optional> *time;
@property (nonatomic, copy)NSString<Optional> *type;
@end
