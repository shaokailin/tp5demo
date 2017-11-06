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
#import "YYModel.h"
#import "PPSSLoginMainVC.h"
#import "AppDelegate.h"
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
        _isShowAlertAndHiden = YES;
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        _isShowAlertAndHiden = YES;
    }
    return self;
}
- (RACSignal *)requestWithPropertyEntity:(LSKParamterEntity *)entity {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        NSInteger taskIdentifier = [LSKHttpManager httpReuquestWithEntity:entity success:^(NSUInteger identifier, id model) {
            if (self.isShowAlertAndHiden) {
                [SKHUD dismiss];
            }
            LSKLog("api=%@---class=%@---%@",entity.requestApi,NSStringFromClass(entity.responseObject),model);
            [self removeLoadingIdentifier:identifier];
            LSKBaseResponseModel *object = [entity.responseObject yy_modelWithJSON:model];
            if (object.code == 4) {
                [self tokenOvertimeEvent];
            }else {
                [subscriber sendNext:object];
            }
            [subscriber sendCompleted];
        } failure:^(NSUInteger identifier, NSError *error) {
            LSKLog("error===api=%@---class=%@---%@",entity.requestApi,NSStringFromClass(entity.responseObject),error);
            if (self.isShowAlertAndHiden) {
                [SKHUD showNetworkErrorMessageInView:self.currentView];
            }
            [self removeLoadingIdentifier:identifier];
            [subscriber sendError:nil];
        }];
        if (taskIdentifier != -1) {
            [self.loadingArray addObject:@(taskIdentifier)];
        }
        return nil;
    }];
}
- (void)tokenOvertimeEvent {
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号在别的手机上登陆或者由于您长久没有使用此账号，需要重新登陆!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新登陆", nil];
    @weakify(self)
    [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 0) {
            [KUserMessageManager removeUserMessage];
            [((AppDelegate *)[UIApplication sharedApplication].delegate) windowRootControllerChange:NO];
        }else {
            KUserMessageManager.userToken = nil;
            PPSSLoginMainVC *loginVC = [[PPSSLoginMainVC alloc]init];
            loginVC.inType = LoginMainInType_Token;
            UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self.currentController presentViewController:loginNavi animated:YES completion:nil];
        }
        [KUserMessageManager hidenAlertView];
    }];
    [KUserMessageManager showAlertView:alter weight:1];
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
