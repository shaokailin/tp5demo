//
//  LSKBaseViewController.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSKBaseVCDelegate.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface LSKBaseViewController : UIViewController <LSKBaseVCDelegate>
@property (nonatomic, readonly,assign) CGFloat tabbarHeight;
@property (nonatomic, readonly,assign) CGFloat tabbarBetweenHeight;
@property (nonatomic, readonly,assign) CGFloat navibarHeight;
@property (nonatomic, readonly, assign) CGFloat viewMainHeight;
/**
 添加返回按钮
 */
- (void)addNavigationBackButton;
/**
 重写返回按钮点击事件
 */
- (void)navigationBackClick;
/**
 添加导行条左边按钮
 */
- (void)addLeftNavigationButtonWithNornalImage:(NSString *)nornalImage
                                  seletedImage:(NSString *)seletedImage
                                        target:(id)target
                                        action:(SEL)action;
- (void)addLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
/**
 添加导行条右边按钮
 */
- (void)addRightNavigationButtonWithNornalImage:(NSString *)nornalImage
                                   seletedIamge:(NSString *)seletedImage
                                         target:(id)target
                                         action:(SEL)action;
- (void)addRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  添加一个通知
 */
-(void)addNotificationWithSelector:(SEL)selector name:(NSString *)name;
/**
 *  移除一个通知
 */
-(void)removeNotificationWithName:(NSString *)name;
@end
