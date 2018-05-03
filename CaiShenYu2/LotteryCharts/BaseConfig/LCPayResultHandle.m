//
//  LCPayResultHandle.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/2/9.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPayResultHandle.h"

@implementation LCPayResultHandle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static LCPayResultHandle *instance;
    dispatch_once(&onceToken, ^{
        instance = [[LCPayResultHandle alloc] init];
    });
    return instance;
}
#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
     if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxPayResultCallBlack:)]) {
                    [self.delegate wxPayResultCallBlack:YES];
                }
                break;
                
            default:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxPayResultCallBlack:)]) {
                    [self.delegate wxPayResultCallBlack:NO];
                }
                break;
        }
    }
    
}
@end
