//
//  FSDateTool.m
//  Gank
//
//  Created by 佛手 on 2018/3/11.
//  Copyright © 2018年 CoderKo1o. All rights reserved.
//

#import "FSDateTool.h"

@implementation FSDateTool

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];

    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+(NSInteger)compareCurrentDateWith:(NSString *)aDate
{
    NSInteger aa=0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:[FSDateTool getCurrentTimes]];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        //        相等  aa=0
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
    }
    
    return aa;
}

@end
