//
//  VideoModel.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VideoModel : JSONModel
//“user_nicename”: “未来”,
//“photoid”: “334412”,
//“uid”: “265381”,
//“uploadfiles”: “http://img.jnooo.cc/dating/2017-04-24/16/5f06ee68e54861120bdb39371a72258a.jpeg“,
//“mp4”: “http://img.jnooo.cc/dating/2017-04-24/16/467697ab6744ff00b67168a74b223180.mp4“

@property (nonatomic, copy)NSString<Optional> *user_nicename;
@property (nonatomic, copy)NSString<Optional> *photoid;
@property (nonatomic, copy)NSString<Optional> *uploadfiles;
@property (nonatomic, copy)NSString<Optional> *mp4;
@property (nonatomic, copy)NSString<Optional> *uid;
@property (nonatomic, copy)NSString<Optional> *flag;
@property (nonatomic, copy)NSString<Optional> *age;
@property (nonatomic, copy)NSString<Optional> *sex;


@end
