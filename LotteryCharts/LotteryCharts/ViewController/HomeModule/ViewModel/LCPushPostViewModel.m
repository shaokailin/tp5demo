//
//  LCPushPostViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPushPostViewModel.h"
#import "QiniuSDK.h"
#import "LCUserModuleAPI.h"
#import "LCBaseResponseModel.h"
#import "LCHomeModuleAPI.h"
#import "LCPublicMethod.h"
@interface LCPushPostViewModel ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *vipContent;
@property (nonatomic, copy) NSMutableArray *mediaUrlArray;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, strong) RACCommand *mediaTokenCommand;
@property (nonatomic, copy) NSString *mediaToken;
@property (nonatomic, strong) QNUploadManager *upManager;
@property (nonatomic, strong) RACCommand *pushPostCommand;
@end
@implementation LCPushPostViewModel
- (void)bindPushPostSignal {
    @weakify(self)
    [self.titleSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.title = x;
    }];
    [self.contentSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.content = x;
    }];
    [self.vipSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.vipContent = x;
    }];
}
- (void)delectMedia:(NSInteger)type index:(NSInteger)index {
    if (!_mediaToken) {
        return;
    }
    if (type == 0 && _mediaUrlArray && _mediaUrlArray.count > 0 && index < _mediaUrlArray.count) {
        [_mediaUrlArray removeObjectAtIndex:index];
    }else {
        self.isVoice = NO;
        self.audioUrl = nil;
    }
}
- (void)pushPostActionEvent {
    if (!KJudgeIsNullData(self.title)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入标题"];
        return;
    }
    if (!KJudgeIsNullData(self.content)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入内容"];
        return;
    }
    if (!self.imageArray || self.imageArray.count == 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"至少要有1张图片"];
        return;
    }
    if (self.showType == -1) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选中查看方式"];
        return;
    }
    if (self.showType == 1 && (!KJudgeIsNullData(self.showMoney) || [self.showMoney integerValue] <= 0)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入查看金额并且要大于0币"];
        return;
    }
    [SKHUD showLoadingDotInWindow];
    [self.mediaTokenCommand execute:nil];
    
}
- (NSMutableArray *)mediaUrlArray {
    if (!_mediaUrlArray) {
        _mediaUrlArray = [[NSMutableArray alloc]init];
    }
    return _mediaUrlArray;
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
                    self.mediaToken = model.response;
                    [self uploadMediaManager];
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
- (void)uploadMediaManager {
    NSInteger index = self.mediaUrlArray.count;
    if (index < self.imageArray.count) {
        NSData *data = UIImageJPEGRepresentation([self.imageArray objectAtIndex:index], 0.95);
        [self uploadMedia:data];
    }else if(self.isVoice && !KJudgeIsNullData(self.audioUrl)) {
        NSURL *url = [LCPublicMethod getRecordUrl];
        LSKLog(@"%@",url.absoluteString);
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self uploadMedia:data];
    }else {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.mediaUrlArray,@"images", nil];
        if (self.isVoice && KJudgeIsNullData(self.audioUrl)) {
            [dict setObject:@{@"url":self.audioUrl,@"time":NSStringFormat(@"%zd",self.time)} forKey:@"record"];
        }
        [self.pushPostCommand execute:[LSKPublicMethodUtil dictionaryTransformToJson:dict]];
    }
}
- (void)uploadMedia:(NSData *)data {
    @weakify(self)
    [self.upManager putData:data key:NSStringFormat(@"%ld",(NSInteger)([[NSDate date]timeIntervalSince1970] * 1000.0)) token:self.mediaToken
                   complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                       if (info.statusCode == 200 || info.error == nil) {
                           @strongify(self)
                           NSString *mediaUrl = NSStringFormat(@"http://p04dq0z51.bkt.clouddn.com/%@",key);
                           if (self.mediaUrlArray.count < self.imageArray.count) {
                               [self.mediaUrlArray addObject:mediaUrl];
                           }else if (self.isVoice){
                               self.audioUrl = mediaUrl;
                               
                           }
                           [self uploadMediaManager];
                       }else {
                           [SKHUD showMessageInView:self.currentView withMessage:@"上传失败~！"];
                       }
                   } option:nil];
}
- (QNUploadManager *)upManager {
    if (!_upManager) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}
- (RACCommand *)pushPostCommand {
    if (!_pushPostCommand) {
        @weakify(self)
        _pushPostCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI pushPostEvent:self.title content:self.content media:input type:self.showType money:self.showMoney vipMoney:self.vipContent]];
        }];
        [_pushPostCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 200) {
                [SKHUD showMessageInWindowWithMessage:@"发布成功"];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _pushPostCommand;
}


@end
