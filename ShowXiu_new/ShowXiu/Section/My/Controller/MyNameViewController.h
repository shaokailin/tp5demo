//
//  MyNameViewController.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>
// 新建一个协议，协议的名字一般是由“类名+Delegate”
@protocol MyNameViewControllerDelegate <NSObject>

// 代理传值方法
- (void)sendValue:(NSString *)value;

@end
@interface MyNameViewController : UIViewController
@property (nonatomic, strong)NSString *nameString;
// 委托代理人，代理一般需使用弱引用(weak)
@property (weak, nonatomic) id<MyNameViewControllerDelegate> delegate;

@end
