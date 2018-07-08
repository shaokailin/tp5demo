//
//  TXXLWeatherDetailVC.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^WeatherDetailBlock)(NSInteger eventTpye,id data);
@interface TXXLWeatherDetailVC : LSKBaseViewController
@property (nonatomic, strong) WeatherDetailBlock detailBlock;
- (void)listCityEvent:(NSInteger)type object:(id)param;
@end
