//
//  LSKBaseViewModel.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSKParamterEntity;
@interface LSKBaseViewModel : NSObject
//当前界面
@property (nonatomic, readonly, weak) UIView *currentView;
//当前控制器
@property (nonatomic,readonly, weak) UIViewController *currentController;

/**
 初始化ViewModel 需要回调的时候调用

 @param success 成功回调
 @param failure 失败回调
 @return ViewModel
 */
- (instancetype)initWithSuccessBlock :(HttpSuccessBlock)success
                             failure :(HttpFailureBlock)failure;

/**
 开始请求

 @param entity 请求参数
 @return 信号
 */
- (RACSignal *)requestWithPropertyEntity:(LSKParamterEntity *)entity ;

/**
 发生成功回调

 @param identifier 类型区分别的请求类型
 @param model 任何id类型的参数
 */
- (void)sendSuccessResult:(NSUInteger)identifier model:(id)model;
/**
 发生失败回调
 
 @param identifier 类型区分别的请求类型
 @param error 错误类型
 */
- (void)sendFailureResult:(NSUInteger)identifier error:(NSError *)error;
@end
