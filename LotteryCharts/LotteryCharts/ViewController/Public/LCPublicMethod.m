//
//  LCPublicMethod.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPublicMethod.h"

@implementation LCPublicMethod
+ (NSURL *)getRecordUrl {
    NSFileManager *filePathmanger = [NSFileManager defaultManager];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"/Record"];
    [filePathmanger createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/%@/postAudio.aac", filePath]];
    return url;
}
@end
