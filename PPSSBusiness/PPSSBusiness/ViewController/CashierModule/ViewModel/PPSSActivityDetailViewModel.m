//
//  PPSSActivityDetailViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailViewModel.h"
#import "PPSSCashierApi.h"
#import <YYModel/YYModel.h>
#import "PPSSActivityEditResultModel.h"
#import "PPSSOrderApi.h"
#import "PPSSShopListModel.h"
@interface PPSSActivityDetailViewModel ()
{
    BOOL _isLoadShopList;
}
@property (nonatomic, strong) RACCommand *shopListCommond;
@property (nonatomic, strong) RACCommand *editCommand;
@end
@implementation PPSSActivityDetailViewModel
- (void)editActivityEvent:(PPSSActivityModel *)model {
    NSMutableDictionary *dict = nil;
    if (self.editType == 1 || self.editType == 2) {
        if (!KJudgeIsNullData(model.shopId)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择要参加活动的门店"];
            return;
        }
        if (!KJudgeIsNullData(model.promotionStartTime)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择活动开始时间"];
            return;
        }
        if (! KNullTransformString(model.promotionEndTime)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择活动结束时间"];
            return;
        }
        NSString *formatter = self.activityType == 0 ? @"yyyy-MM-dd":@"yyyy-MM-dd HH:mm:ss";
        NSDate *startTime = [NSDate stringTransToDate:model.promotionStartTime withFormat:formatter];
        NSDate *endTime = [NSDate stringTransToDate:model.promotionEndTime withFormat:formatter];
        if ([startTime timeIntervalSinceDate:endTime] > 0) {
            [SKHUD showMessageInView:self.currentView withMessage:@"活动的开始时间不能等于或者大于结束时间"];
            return;
        }
        if (self.activityType == 0) {
            if (model.promotionTime.count > 0) {
                NSDictionary *dict = [model.promotionTime lastObject];
                BOOL startHas = KJudgeIsNullData([dict objectForKey:@"startTime"]);
                BOOL lastHas = KJudgeIsNullData([dict objectForKey:@"endTime"]);
                if (!startHas && !lastHas) {
                    NSMutableArray *array = [model.promotionTime mutableCopy];
                    [array removeLastObject];
                    if (array.count == 0) {
                        [SKHUD showMessageInView:self.currentView withMessage:@"抢饭点活动必须设置时间段，请先选择时间段"];
                        return;
                    }else {
                        model.promotionTime = array;
                    }
                }else if ((startHas && !lastHas) || (!startHas && lastHas)) {
                    [SKHUD showMessageInView:self.currentView withMessage:NSStringFormat(@"请完善时间段%lu的时间选择",(unsigned long)model.promotionTime.count)];
                    return;
                }
            }
        }else {
            model.promotionTime = nil;
        }
        if (!KJudgeIsNullData(model.promotionIntensity)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择要参与的活动力度"];
            return;
        }
        if (!KJudgeIsNullData(model.periodOfValidity)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入现金券的有效期"];
            return;
        }
        if (self.activityType == 2) {
            if (!KJudgeIsNullData(model.setPoint) ||!KJudgeIsNullData(model.pointChangeBalance)) {
                [SKHUD showMessageInView:self.currentView withMessage:@"请先完善兑换规则"];
                return;
            }
        }
        if (!KJudgeIsNullData([model.promotionBody stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入活动介绍"];
            return;
        }
        dict = [[model yy_modelToJSONObject] mutableCopy];
        [dict setObject:@([startTime timeIntervalSince1970]) forKey:@"promotionStartTime"];
        [dict setObject:@([endTime timeIntervalSince1970]) forKey:@"promotionEndTime"];
        [dict setObject:[model.promotionIntensity substringToIndex:model.promotionIntensity.length - 1] forKey:@"promotionIntensity"];
        [dict removeObjectForKey:@"shopName"];
        [dict removeObjectForKey:@"promotionPercent"];
        [dict removeObjectForKey:@"promotionUsers"];
        [dict removeObjectForKey:@"promotionPrice"];
        [dict removeObjectForKey:@"promotionMoney"];
        if (self.activityType != 2) {
            [dict removeObjectForKey:@"setPoint"];
            [dict removeObjectForKey:@"pointChangeBalance"];
        }
        [dict removeObjectForKey:@"promotionLimitTime"];
    }else {
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.promotionId,@"promotionId", nil];
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.editCommand execute:dict];
}
- (RACCommand *)editCommand {
    if (!_editCommand) {
        @weakify(self)
        _editCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi editActivityWithType:self.editType model:input]];
        }];
        [_editCommand.executionSignals.flatten subscribeNext:^(PPSSActivityEditResultModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [self sendSuccessResult:0 model:model.promotionId];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _editCommand;
}

#pragma mark - 门店列表
- (BOOL)getShopList {
    if (!_isLoadShopList) {
        _isLoadShopList = YES;
        [SKHUD showLoadingDotInWindow];
        [self.shopListCommond execute:nil];
        return YES;
    }
    return NO;
    
}
- (RACCommand *)shopListCommond {
    if (!_shopListCommond) {
        @weakify(self)
        _shopListCommond = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSOrderApi getShopList]];
        }];
        [_shopListCommond.executionSignals.flatten subscribeNext:^(PPSSShopListModel *model) {
            @strongify(self)
            if (model.code == 0 || model.code == 11) {
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    self.shopListArray = model.data;
                }else {
                    self.shopListArray = nil;
                }
                [self sendSuccessResult:1 model:nil];
            }else {
                _isLoadShopList = NO;
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
        [_shopListCommond.errors subscribeNext:^(NSError * _Nullable x) {
            _isLoadShopList = NO;
        }];
    }
    return _shopListCommond;
}

@end
