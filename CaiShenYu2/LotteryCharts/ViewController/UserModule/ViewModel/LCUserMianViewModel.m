//
//  LCUserMianViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMianViewModel.h"
#import "LCLoginModuleAPI.h"
#import "LCUserModuleAPI.h"
#import "LSKBaseResponseModel.h"
#import "AppDelegate.h"
#import "LCBaseResponseModel.h"
#import "QiniuSDK.h"
#import "LCUserHomeMessageModel.h"
@interface LCUserMianViewModel()
@property (nonatomic, strong) RACCommand *loginOutCommand;
@property (nonatomic, strong) RACCommand *mediaTokenCommand;
@property (nonatomic, copy) NSString *mediaToken;
@property (nonatomic, strong) QNUploadManager *upManager;
@property (nonatomic, strong) RACCommand *updatePhotoCommand;
@property (nonatomic, copy) NSString *mediaUrl;
@property (nonatomic, strong) RACCommand *userMessageCommand;
@property (nonatomic, strong) RACCommand *signCommand;
@property (nonatomic, strong) RACCommand *updateBgImageCommand;
@property (nonatomic, strong) RACCommand *noticeCommand;
@end
@implementation LCUserMianViewModel
- (void)getUserMessage {
    [SKHUD showLoadingDotInWindow];
    [self.userMessageCommand execute:nil];
}
- (RACCommand *)userMessageCommand {
    if (!_userMessageCommand) {
        @weakify(self)
        _userMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUsermModuleMessage]];
        }];
        [_userMessageCommand.executionSignals.flatten subscribeNext:^(LCUserHomeMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                model.user_info.token = kUserMessageManager.token;
                [kUserMessageManager saveUserMessage:model.user_info isLogin:NO];
                self.messageModel = model;
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _userMessageCommand;
}
- (void)userSignClickEvent {
    [SKHUD showLoadingDotInWindow];
    [self.signCommand execute:nil];
}
- (RACCommand *)signCommand {
    if (!_signCommand) {
        @weakify(self)
        _signCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI userSignEvent]];
        }];
        [_signCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"签到成功"];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _signCommand;
}
#pragma mark 退出登录
- (void)loginOutClickEvent {
    [SKHUD showLoadingDotInWindow];
    [self.loginOutCommand execute:nil];
}
- (RACCommand *)loginOutCommand {
    if (!_loginOutCommand) {
        @weakify(self)
        _loginOutCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI loginOutEvent:kUserMessageManager.token]];
        }];
        [_loginOutCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            [kUserMessageManager removeUserMessage];
            [SKHUD showMessageInWindowWithMessage:@"退出成功~!"];
            [((AppDelegate *)[UIApplication sharedApplication].delegate)changeLoginState];
        }];
    }
    return _loginOutCommand;
}

#pragma mark - 更新头像
- (void)updateUserPhoto {
    [SKHUD showLoadingDotInWindow];
    [self.mediaTokenCommand execute:nil];
}
- (RACCommand *)mediaTokenCommand {
    if (!_mediaTokenCommand) {
        @weakify(self)
        _mediaTokenCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getMediaToken]];
        }];
        [_mediaTokenCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (KJudgeIsNullData(model.response)) {
                    NSData *data = UIImageJPEGRepresentation(self.photoImage, 0.95);
                    [self.upManager putData:data key:NSStringFormat(@"%ld",(NSInteger)([[NSDate date]timeIntervalSince1970] * 1000.0)) token:model.response
                              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                  if (info.statusCode == 200 || info.error == nil) {
                                      self.mediaUrl = NSStringFormat(@"http://p04dq0z51.bkt.clouddn.com/%@",key);
                                      if (self.editType == 2) {
                                          [self.updatePhotoCommand execute:nil];
                                      }else {
                                          [self.updateBgImageCommand execute:nil];
                                      }
                                      
                                  }else {
                                      [SKHUD showMessageInView:self.currentView withMessage:@"上传失败~！"];
                                  }
                              } option:nil];
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"系统出错啦~!"];
                }
            }else {
                @strongify(self)
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _mediaTokenCommand;
}
- (QNUploadManager *)upManager {
    if (!_upManager) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}
- (RACCommand *)updatePhotoCommand {
    if (!_updatePhotoCommand) {
        @weakify(self)
        _updatePhotoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI updateUserPhoto:self.mediaUrl]];
        }];
        [_updatePhotoCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"头像更换成功"];
                kUserMessageManager.logo = self.mediaUrl;
                [self sendSuccessResult:1 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _updatePhotoCommand;
}

- (RACCommand *)updateBgImageCommand {
    if (!_updateBgImageCommand) {
        @weakify(self)
        _updateBgImageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI updateBgImage:self.mediaUrl]];
        }];
        [_updateBgImageCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"背景更换成功"];
                kUserMessageManager.bglogo = self.mediaUrl;
                [self sendSuccessResult:10 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _updateBgImageCommand;
}

- (void)getNoticeCount {
    [self.noticeCommand execute:nil];
}
- (RACCommand *)noticeCommand {
    if (!_noticeCommand) {
        @weakify(self)
        _noticeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getNoticeCount]];
        }];
        [_noticeCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                self.count = [[model.response objectForKey:@"count"] integerValue];
                [self sendSuccessResult:300 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:@""];
                [self sendFailureResult:300 error:nil];
            }
        }];
        [_noticeCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
             [self sendFailureResult:300 error:nil];
        }];
    }
    return _noticeCommand;
}
@end
