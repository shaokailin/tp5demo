//
//  PPSSUserApi.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSUserApi : NSObject

/**
 获取提现列表

 @param page 页数
 @return 参数
 */
+ (LSKParamterEntity *)getWithdrawListWithPage:(NSInteger)page;

/**
 提现申请

 @param money 金钱
 @return 参数
 */
+ (LSKParamterEntity *)withdrawApplyEvent:(NSString *)money;

/**
 获取用户模块首页的信息

 @return 参数
 */
+ (LSKParamterEntity *)getUserHomeMessage;

/**
 获取收银员列表

 @param page 页数
 @param searchTest 搜索内容
 @return 参数
 */
+ (LSKParamterEntity *)getCashierList:(NSInteger)page searchText:(NSString *)searchTest;

/**
 编辑添加收银员

 @param editType 1保存，2修改，3删除
 @param modelDict 收银员的信息
 @return 参数
 */
+ (LSKParamterEntity *)editCashierWithType:(NSInteger)editType model:(NSDictionary *)modelDict;

/**
 修改会员的标签 和 意见反馈提交

 @param userId 会员id 有传 说明是修改标签，没有传 说明是 意见反馈
 @param remark 内容
 @return 参数
 */
+ (LSKParamterEntity *)editRemarkTextWithUserId:(NSString *)userId remark:(NSString *)remark  type:(NSInteger)type;
@end
