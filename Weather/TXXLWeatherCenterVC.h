//
//  TXXLWeatherCenterVC.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^DefaultWeatherChangeBlock)(NSInteger type,id data);//0 只是天气修改， 1，修改城市
@interface TXXLWeatherCenterVC : LSKBaseViewController
@property (nonatomic, copy) DefaultWeatherChangeBlock changeBlock;
@property (nonatomic, copy) NSDictionary *defaultData;
@end
