//
//  LSKWebEventHandleManager.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKWebEventHandleManager.h"
NSString * const WebEventHandle = @"WebEventHandle";

@implementation LSKWebEventHandleManager
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:WebEventHandle]) {
        NSString *methodName = message.body[@"methodName"];
        NSDictionary *params = message.body[@"params"];
        NSString *callBackName = message.body[@"callBackName"];
        //需要回调
        if (callBackName) {
            __weak  WKWebView *weakWebView = _webView;
            [self interactWitMethodName:methodName params:params :^(id response) {
                NSString *js = [NSString stringWithFormat:@"JKEventHandler.callBack('%@',%@);",callBackName,response];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakWebView evaluateJavaScript:js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                    }];
                });
            }];
        }else{
            [self interactWitMethodName:methodName params:params :nil];
        }
    }
}

- (void)interactWitMethodName:(NSString *)methodName params:(NSDictionary *)params :(void(^)(id response))callBack{
    if (params) {
        methodName = [NSString stringWithFormat:@"%@:",methodName];
        if (callBack) {
            methodName = [NSString stringWithFormat:@"%@:",methodName];
            SEL selector =NSSelectorFromString(methodName);
            NSArray *paramArray =@[params,callBack];
            if ([self respondsToSelector:selector]) {
                [self JKperformSelector:selector withObjects:paramArray];
            }
        }else{
            SEL selector =NSSelectorFromString(methodName);
            NSArray *paramArray =@[params];
            if ([self respondsToSelector:selector]) {
                [self JKperformSelector:selector withObjects:paramArray];
            }
            
        }
    }else{
        
        if (callBack) {
            methodName = [NSString stringWithFormat:@"%@:",methodName];
            SEL selector =NSSelectorFromString(methodName);
            NSArray *paramArray =@[callBack];
            if ([self respondsToSelector:selector]) {
                [self JKperformSelector:selector withObjects:paramArray];
            }
        }else{
            SEL selector =NSSelectorFromString(methodName);
            
            if ([self respondsToSelector:selector]) {
                [self JKperformSelector:selector withObjects:nil];
            }
            
        }
        
    }
}

- (id)JKperformSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}
@end
