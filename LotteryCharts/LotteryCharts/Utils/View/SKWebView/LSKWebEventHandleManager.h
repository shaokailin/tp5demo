//
//  LSKWebEventHandleManager.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
extern NSString * const WebEventHandle;
@interface LSKWebEventHandleManager : NSObject<WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end
