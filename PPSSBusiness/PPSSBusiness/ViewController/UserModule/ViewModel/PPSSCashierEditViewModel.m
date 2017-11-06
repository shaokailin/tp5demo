//
//  PPSSCashierEditViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierEditViewModel.h"
#import "PPSSCashierExitResultModel.h"
#import "PPSSUserApi.h"
#import <YYModel/YYModel.h>
@interface PPSSCashierEditViewModel ()
@property (nonatomic, strong) RACCommand *editCommand;
@end
@implementation PPSSCashierEditViewModel
- (void)editCashierEvent:(PPSSCashierModel *)model {
    NSMutableDictionary *dict = nil;
    if (self.editType == 1 || self.editType == 2) {
        if (!KJudgeIsNullData(model.name)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入收银员姓名"];
            return;
        }
        if (!KJudgeIsNullData(model.phone)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入收银员电话"];
            return;
        }
        if (![model.phone validateMobilePhone]) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的手机号码"];
            return;
        }
        if (self.editType == 1 && ![self isValidatePassword:model.password againPwd:model.againPassword]) {
            return;
        }
        if (self.editType == 2) {
            if (KJudgeIsNullData(model.password)) {
                if (![self isValidatePassword:model.password againPwd:model.againPassword]) {
                    return;
                }
            }
        }
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.name,@"name",model.phone,@"phone", nil];
        if (KJudgeIsNullData(model.userId)) {
            [dict setObject:model.userId forKey:@"userId"];
        }
        if (KJudgeIsNullData(model.password)) {
            [dict setObject:model.password forKey:@"password"];
        }
        
    }else {
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.userId,@"userId", nil];
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.editCommand execute:dict];
}
- (BOOL)isValidatePassword:(NSString *)password againPwd:(NSString *)againPwd {
    if (!KJudgeIsNullData(password)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入密码~!"];
        return NO;
    }
    if (password.length < 6 || password.length > 20) {
        [SKHUD showMessageInView:self.currentView withMessage:@"密码个数是6-20位~!"];
        return NO;
    }
    if (![password isEqualToString:againPwd]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"输入的2次密码不一样~!"];
        return NO;
    }
    return YES;
}
- (RACCommand *)editCommand {
    if (!_editCommand) {
        @weakify(self)
        _editCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi editCashierWithType:self.editType model:input]];
        }];
        [_editCommand.executionSignals.flatten subscribeNext:^(PPSSCashierExitResultModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [self sendSuccessResult:0 model:model.userId];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _editCommand;
}
@end
