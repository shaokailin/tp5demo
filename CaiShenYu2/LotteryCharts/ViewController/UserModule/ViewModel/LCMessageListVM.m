//
//  LCMessageListVM.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/22.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMessageListVM.h"
#import "LCUserModuleAPI.h"
#import "LCUserSettingModel.h"
@interface LCMessageListVM ()
@property (nonatomic, strong) RACCommand *settingListCommand;
@property (nonatomic, strong) RACCommand *settingChangeCommand;
@end
@implementation LCMessageListVM
- (void)getUserNoticeSetting {
    [SKHUD showLoadingDotInWindow];
    [self.settingListCommand execute:nil];
}
- (void)changeUserSetting {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.settingChangeCommand execute:nil];
}
- (RACCommand *)settingListCommand {
    if (!_settingListCommand) {
        @weakify(self)
        _settingListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getNoticeSetting]];
        }];
        [_settingListCommand.executionSignals.flatten subscribeNext:^(LCUserSettingModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                self.model = model;
                [self sendSuccessResult:0 model:nil];
            }
        }];
    }
    return _settingListCommand;
}
- (RACCommand *)settingChangeCommand {
    if (!_settingChangeCommand) {
        @weakify(self)
        _settingChangeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI changeNoticeSetting:self.type == 0?self.changeValue:self.model.comment_reply focus:self.type == 2?self.changeValue:self.model.focus reward:self.type == 1?self.changeValue:self.model.reward system:self.type == 4?self.changeValue:self.model.system]];
        }];
        [_settingChangeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                switch (self.type) {
                    case 0:
                        self.model.comment_reply = self.changeValue;
                        break;
                    case 1:
                        self.model.reward = self.changeValue;
                        break;
                    case 2:
                        self.model.focus = self.changeValue;
                        break;
                    case 4:
                        self.model.system = self.changeValue;
                        break;
                    default:
                        break;
                }
                [self sendSuccessResult:0 model:nil];
            }
        }];
    }
    return _settingChangeCommand;
}
@end
