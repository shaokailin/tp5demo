//
//  UIViewController+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "UIViewController+Extend.h"

@implementation UIViewController (Extend)
#pragma 关闭全屏布局和滚动不全局
- (void)setupNotFullScreen {
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
}
- (void)addNavigationLeftButton:(UIBarButtonItem *)tLeftButton {
    if ([LSKPublicMethodUtil getiOSSystemVersion] >= 11) {
        self.navigationItem.leftBarButtonItem = tLeftButton;
    }else {
        self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem initBarButtonItemSpace],tLeftButton];
    }
    
}
- (void)addNavigationRightButton:(UIBarButtonItem *)tRightButton {
    self.navigationItem.rightBarButtonItem = tRightButton;
}
- (void)addNavigationLeftButtons:(NSArray<UIBarButtonItem *> *)leftButtons {
    if (leftButtons && leftButtons.count > 0) {
        NSMutableArray *buttons = [leftButtons mutableCopy];
        if ([LSKPublicMethodUtil getiOSSystemVersion] >= 11) {
        }else {
            [buttons insertObject:[UIBarButtonItem initBarButtonItemSpace] atIndex:0];
        }
        self.navigationItem.leftBarButtonItems = buttons;
    }
}
- (void)addNavigationRightButtons:(NSArray<UIBarButtonItem *> *)rightButtons {
    if (rightButtons && rightButtons.count > 0) {
        self.navigationItem.rightBarButtonItems = rightButtons;
    }
}
@end

