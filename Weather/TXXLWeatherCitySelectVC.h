//
//  TXXLWeatherCitySelectVC.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^SelectCityBlock)(NSArray *data);
typedef void (^AddCityBlock)(NSInteger type,id object);
@interface TXXLWeatherCitySelectVC : LSKBaseViewController
@property (nonatomic, copy) AddCityBlock addBlock;
@property (nonatomic, copy) SelectCityBlock selectBlock;
@end
