//
//  LSKBaseViewModel.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LSKHttpManager.h"
#import "LSKBaseResponseModel.h"
#import "LSKParamterEntity.h"
#import "YYModel.h"
@interface LSKBaseViewModel ()
@property (nonatomic ,strong) NSMutableArray *loadingArray;
@property (nonatomic, copy) HttpSuccessBlock successBlock;
@property (nonatomic, copy) HttpFailureBlock failureBlock;
@property (nonatomic, readwrite, weak) UIView *currentView;
@property (nonatomic, readwrite, weak) UIViewController *currentController;
@end
@implementation LSKBaseViewModel
- (instancetype)initWithSuccessBlock:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    if (self = [super init]) {
        _successBlock = success;
        _failureBlock = failure;
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (RACSignal *)requestWithPropertyEntity:(LSKParamterEntity *)entity {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        NSInteger taskIdentifier = [LSKHttpManager httpReuquestWithEntity:entity success:^(NSUInteger identifier, id model) {
            [SKHUD dismiss];
            LSKLog("api=%@---class=%@---%@",entity.requestApi,NSStringFromClass(entity.responseObject),model);
            [self removeLoadingIdentifier:identifier];
            LSKBaseResponseModel *object = [entity.responseObject yy_modelWithJSON:model];
            [subscriber sendNext:object];
            [subscriber sendCompleted];
        } failure:^(NSUInteger identifier, NSError *error) {
            LSKLog("error===api=%@---class=%@---%@",entity.requestApi,NSStringFromClass(entity.responseObject),error);
            [self removeLoadingIdentifier:identifier];
            [SKHUD showNetworkErrorMessageInView:self.currentView];
            [self sendFailureResult:0 error:nil];
            [subscriber sendError:nil];
        }];
        if (taskIdentifier != -1) {
            [self.loadingArray addObject:@(taskIdentifier)];
        }
        return nil;
    }];
}

#pragma mark - 结果的回调
- (void)sendSuccessResult:(NSUInteger)identifier model:(id)model{
    if (_successBlock) {
        _successBlock(identifier,model);
    }
}
- (void)sendFailureResult:(NSUInteger)identifier error:(NSError *)error {
    if (_failureBlock) {
        _failureBlock(identifier,error);
    }
}
#pragma mark 获取当前的界面和控制器
- (UIView *)currentView {
    return self.currentController.view;
}
- (UIViewController *)currentController {
    if (!_currentController) {
        _currentController = [LSKViewFactory getCurrentViewController];
    }
    return _currentController;
}
#pragma mark 移除未加载完成的
//为了当页面消失的时候，请求未结束，要释放所有当前正在加载的
-(void)removeLoadingIdentifier :(NSUInteger)taskIndetifer {
    [self.loadingArray removeObject:@(taskIndetifer)];
}
- (void)dealloc {
    if (_loadingArray && _loadingArray.count > 0) {
        [[LSKHttpManager sharedLSKHttpManager]removeHttpLoadingByIdentifier:_loadingArray];
    }
}
-(NSMutableArray *)loadingArray {
    if (_loadingArray == nil) {
        _loadingArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _loadingArray;
}
@end
