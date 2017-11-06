//
//  LSKLineTableView.h
//  SingleStore
//
//  Created by lsklan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,LSKLineTableViewStype) {
    LSKLineTableViewStype_Top = 0,
    LSKLineTableViewStype_Botton
};


@protocol LSKTableViewDelegate <NSObject>
@required
- (NSInteger)lsk_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)lsk_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSInteger)index;
@optional
- (void)lsk_tableView:(UITableView *)tableView didSelectRowAtIndex:(NSInteger)index;
- (CGFloat)lsk_heightForRowAtIndex:(NSInteger)index;
- (void)pullDownRefresh;
- (void)pullUpLoadMore;
@end
@interface LSKLineTableView : UIView
@property (nonatomic, readonly, strong) UITableView *tableView;
//代理
@property (nonatomic, weak,) id<LSKTableViewDelegate> delegate;
//是否支持点击
@property (nonatomic, assign) BOOL isAllowSelect;
//行高
@property (nonatomic, assign) CGFloat rowHeight;
//头视图
@property (nonatomic, strong) UIView *tableHeaderView;
//尾视图
@property (nonatomic, strong) UIView *tableFooterView;

/**
 初始化线TableView

 @param stype 线所在位置，上或者下
 @param refreshAction 刷新事件
 @param moreAction 加载更多事件
 @return 当前视图
 */
- (instancetype)initWithStyle:(LSKLineTableViewStype)stype refresh:(SEL)refreshAction LoadMore:(SEL)moreAction ;

/**
 注册cell class

 @param cellClass 类名
 @param identifier 标识符
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 编辑表内容

 @param type 编辑样式
 @param start 开始位子
 @param end 结束位子
 @param section 某个模块
 @param animation 动画效果
 */
- (void)exitTableViewWithType:(LSKTableViewExitType)type indexPathStart:(NSInteger)start indexPathEnd:(NSInteger)end section:(NSInteger)section animation:(UITableViewRowAnimation)animation;

/**
 重新刷新
 */
- (void)reloadTableView;

/**
 头部结束刷新
 */
- (void)endHearerRefreshing;

/**
 尾部结束刷新
 */
- (void)endFooterRefreshing;
@end
