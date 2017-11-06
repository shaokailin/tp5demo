//
//  PPSSComplaintViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/25.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSComplaintViewModel.h"
#import "LSKBaseResponseModel.h"
#import "PPSSUserApi.h"
@interface PPSSComplaintViewModel ()
@property (nonatomic, strong) RACCommand *uploadCommand;
@end
@implementation PPSSComplaintViewModel
- (void)uploadEditText {
    if (!KJudgeIsNullData([self.textString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入内容"];
        return;
    }
    if (!KJudgeIsNullData(self.userId) && self.type < 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选择投诉建议类型"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.uploadCommand execute:nil];
}
- (RACCommand *)uploadCommand {
    if (!_uploadCommand) {
        @weakify(self)
        _uploadCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
             @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi editRemarkTextWithUserId:self.userId remark:self.textString type:self.type]];
        }];
        [_uploadCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                if (!KJudgeIsNullData(self.userId)) {
                    [SKHUD showMessageInView:self.currentView withMessage:@"提交成功"];
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"修改成功"];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _uploadCommand;
}
@end
