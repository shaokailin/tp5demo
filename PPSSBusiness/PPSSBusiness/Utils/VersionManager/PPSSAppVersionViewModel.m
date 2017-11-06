//
//  PPSSAppVersionViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppVersionViewModel.h"
#import "PPSSAppVersionApi.h"
@interface PPSSAppVersionViewModel()
@property (nonatomic, strong) RACCommand *appVersionCommand;
@end
@implementation PPSSAppVersionViewModel

- (void)getAppVersionData {
    [self.appVersionCommand execute:nil];
}

- (RACCommand *)appVersionCommand {
    if (!_appVersionCommand) {
        @weakify(self)
        _appVersionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSAppVersionApi getAppVersionData]];
        }];
        [_appVersionCommand.executionSignals.flatten subscribeNext:^(id model) {
            @strongify(self)
            [self sendSuccessResult:0 model:model];
        }];
        [_appVersionCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _appVersionCommand;
}
@end
