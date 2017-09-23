//
//  PPSSPersonHeadView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PersonHeaderType) {
    PersonHeaderType_Person,
    PersonHeaderType_Member
};
typedef void (^PersonHeaderClickBlock) (NSInteger type);
@interface PPSSPersonHeadView : UIView
@property (nonatomic, copy) PersonHeaderClickBlock clickBlock;

- (instancetype)initWithPersonType:(PersonHeaderType)headerType;
//设置信息的 头像 、 名字、 电话号码
- (void)setupUserPhoto:(NSString *)photo name:(NSString *)name phone:(NSString *)phone;

/**
 设置个人中心

 @param share 分润
 @param allAmount 总额
 @param memberCount 会员数
 */
- (void)setupMessageWithShareMoney:(NSString *)share allAmount:(NSString *)allAmount memberCount:(NSString *)memberCount;

/**
 会员信息

 @param count 消费次数
 @param integral 积分
 @param storedValue 储值
 @param returnCash 已返金额
 */
- (void)setupMessageWithConsumeCount:(NSString *)count integral:(NSString *)integral storedValue:(NSString *)storedValue returnCash:(NSString *)returnCash;
@end
