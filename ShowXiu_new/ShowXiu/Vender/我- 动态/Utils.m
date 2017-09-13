//  Utils.m
//  HopeYunmendian
//
//  Created by wangning on 15/12/23.
//  Copyright © 2015年 wangning. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"


#import <SystemConfiguration/SCNetworkReachability.h>
#import <sys/socket.h>
#import <netdb.h>
#include <sys/xattr.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <AdSupport/ASIdentifierManager.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#include <ifaddrs.h>

//#import <ifaddrs.h>
//#import <arpa/inet.h>
//#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

//static long M_PI01 = 3.14159265358979324;
//static float a = 6378245.0;
//static long ee = 0.00669342162296594323;
//static long x_pi = 3.14159265358979324 * 3000.0 / 180.0;
static Utils *instance = nil;


@implementation Utils


+ (Utils *)shareInstance
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[self alloc] init];
        
    });
    return instance;
}


//判断是否为空字符串
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark - 动态计算label的高度或者宽度
+ (CGSize)setWidthForText:(NSString*)text fontSize:(CGFloat)fontSize labelSize:(CGFloat)labelSize isGetHight:(BOOL)isHight
{
    NSDictionary *parameterDict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:fontSize]};
    
    CGSize titleSize ;
    
    if (isHight)
    {
        titleSize = [text boundingRectWithSize:CGSizeMake(labelSize,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil].size;
    }
    else
    {
        titleSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,labelSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:parameterDict context:nil].size;
    }
    
    return titleSize;
}


+ (CGSize)textSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font text:(NSString *)text
{
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}



@end
