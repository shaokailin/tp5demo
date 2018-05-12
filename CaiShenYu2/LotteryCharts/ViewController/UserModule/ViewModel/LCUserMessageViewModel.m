//
//  LCUserMessageViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageViewModel.h"
#import "LCBaseResponseModel.h"
#import "QiniuSDK.h"
#import "LCUserModuleAPI.h"
@interface LCUserMessageViewModel()
@property (nonatomic, strong) RACCommand *mediaTokenCommand;
@property (nonatomic, copy) NSString *mediaToken;
@property (nonatomic, strong) QNUploadManager *upManager;
@property (nonatomic, strong) RACCommand *updateMessageCommand;
@property (nonatomic, copy) NSString *mediaUrl;
@end
@implementation LCUserMessageViewModel
- (instancetype)init {
    if (self = [super init]) {
        _sexString = -1;
        _mediaUrl = kUserMessageManager.logo;
        _nameString = kUserMessageManager.nickName;
        _sexString = [[kUserMessageManager getMessageManagerForObjectWithKey:kUserMessage_Sex] isEqualToString:@"男"] == YES ? 0:1;
        _birthday = [[NSDate dateWithTimeIntervalSince1970:[[kUserMessageManager getMessageManagerForObjectWithKey:kUserMessage_Birthday]floatValue]]dateTransformToString:@"yyyy/MM/dd"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        _mchnoString = [userDefaults objectForKey:@"user_Mchid2"];
    }
    return self;
}
- (void)updateUserMessage {
    if (!_photoImage && !KJudgeIsNullData(_mediaUrl) ) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选择头像"];
        return;
    }
    if (!KJudgeIsNullData(_nameString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入昵称"];
        return;
    }
    if (!KJudgeIsNullData(_birthday)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选择出生日期"];
        return;
    }
    if (_sexString == -1) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选择性别"];
        return;
    }
    
    
    [SKHUD showLoadingDotInView:self.currentView];
    if (_photoImage) {
        [self.mediaTokenCommand execute:nil];
    }else {
        [self.updateMessageCommand execute:nil];
    }
    
}
- (RACCommand *)mediaTokenCommand {
    if (!_mediaTokenCommand) {
        @weakify(self)
        _mediaTokenCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getMediaToken]];
        }];
        [_mediaTokenCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            NSLog(@"%@", self.photoImage);
            @strongify(self)
            if (model.code == 200) {
                if (KJudgeIsNullData(model.response)) {
                    NSData *data = UIImageJPEGRepresentation(self.photoImage, 0.95);
                    [self.upManager putData:data key:NSStringFormat(@"%ld",(NSInteger)([[NSDate date]timeIntervalSince1970] * 1000.0)) token:model.response
                                   complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                       if (info.statusCode == 200 || info.error == nil) {
                                           self.mediaUrl = NSStringFormat(@"http://p04dq0z51.bkt.clouddn.com/%@",key);
                                           [self.updateMessageCommand execute:nil];
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
- (RACCommand *)updateMessageCommand {
    if (!_updateMessageCommand) {
        @weakify(self)
        _updateMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI updateUserMessage:self.mediaUrl sex:self.sexString == 1?@"女":@"男" nickname:self.nameString birthday:[[NSDate stringTransToDate:self.birthday withFormat:@"yyyy/MM/dd"]timeIntervalSince1970] machid:self->_mchnoString]];
        }];
        [_updateMessageCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"修改成功"];
                kUserMessageManager.logo = self.mediaUrl;
                kUserMessageManager.nickName = self.nameString;
                [kUserMessageManager setMessageManagerForObjectWithKey:kUserMessage_Birthday value:self.birthday];
                [kUserMessageManager setMessageManagerForObjectWithKey:kUserMessage_Sex value:self.sexString == 1?@"女":@"男"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                
                [userDefaults setObject:self->_mchnoString forKey:@"user_Mchid2"];
                
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kUserModule_HomeChangeMessageNotice object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kSign_Change_Notice object:nil];
//                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _updateMessageCommand;
}
@end
