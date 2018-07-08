//
//  TXXLWeatherCityListVC.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^CityListBlock)(NSInteger eventTpye,id object);
@interface TXXLWeatherCityListVC : LSKBaseViewController
@property (nonatomic, copy) NSDictionary *weatherDefaultDict;
@property (nonatomic, copy) CityListBlock listBlock;
- (void)refreshData;
@end
