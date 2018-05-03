//
//  LSKBaseVCDelegate.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSKBaseVCDelegate <NSObject>
@optional
/**
 初始化主视图界面
 */
- (void)initializeMainView;
/**
 绑定的信号
 */
- (void)bindSignal;
/**
 下拉刷新事件
 */
- (void)pullDownRefresh;
/**
 上拉加载更多
 */
- (void)pullUpLoadMore;
@end
