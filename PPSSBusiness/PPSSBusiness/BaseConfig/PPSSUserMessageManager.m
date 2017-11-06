//
//  PPSSUserMessageManager.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "PPSSUserMessageManager.h"
#import "SynthesizeSingleton.h"
#import "PPSSLoginModel.h"
#import "AppDelegate.h"
#import <JPUSHService.h>
#import <AFNetworking/AFNetworking.h>
static NSString * const kUserMessageToken = @"userToken_Save";
static NSString * const kUserMessagePwd = @"userPassword_Save";
static NSString * const kUserMessageAccount = @"userAccount_Save";
static NSString * const kUserMessage_phone = @"userphone_Save";
static NSString * const kUserMessage_power = @"userpower_Save";
static NSString * const kUserMessage_shopName = @"usershopName_Save";
static NSString * const kUserMessage_qcode = @"userqcode_Save";
static NSString * const kUserMessage_username = @"userusername_Save";
static NSString * const kUserMessage_userId = @"useruserId_Save";
static NSString * const kUserMessage_userLogo = @"useruserLogo_Save";
static NSString * const kNoticeIsOpen = @"NoticeIsOpen";
static NSInteger req = 1000;
@interface PPSSUserMessageManager ()
{
    NSTimer *_codeTimer;
    BOOL _isShow;
    NSInteger _currentWeight;
    BOOL _alterCount;
}
@property (nonatomic, strong) NSMutableArray *alertListArray;
@property (nonatomic, assign) NSInteger currentType;//1.添加失败，2.删除失败
@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@end
@implementation PPSSUserMessageManager

SYNTHESIZE_SINGLETON_CLASS(PPSSUserMessageManager);
- (instancetype)init {
    if (self = [super init]) {
        _loginCodeTime = 0;
        _forgetCodeTime = 0;
        _currentType = 0;
        [self getUserMessage];
    }
    return self;
}
- (void)getUserMessage {
    _isRegisterAlia = [self getMessageManagerForBoolWithKey:kNoticeIsOpen];
    _userToken = [self getMessageManagerForObjectWithKey:kUserMessageToken];
    if ([self isLogin]) {
        _phone = [self getMessageManagerForObjectWithKey:kUserMessage_phone];
        _power = [self getMessageManagerForObjectWithKey:kUserMessage_power];
        _qcode = [self getMessageManagerForObjectWithKey:kUserMessage_qcode];
        _username = [self getMessageManagerForObjectWithKey:kUserMessage_username];
        _shopName = [self getMessageManagerForObjectWithKey:kUserMessage_shopName];
        _userId = [self getMessageManagerForObjectWithKey:kUserMessage_userId];
        _logo = [self getMessageManagerForObjectWithKey:kUserMessage_userLogo];
    }
}
- (void)removeUserMessage {
    [self loginOutPushWithAlias];
    NSUserDefaults *userDefault = [self getUserDefault];
    [userDefault removeObjectForKey:kUserMessageToken];
    [userDefault removeObjectForKey:kUserMessage_phone];
    [userDefault removeObjectForKey:kUserMessage_power];
    [userDefault removeObjectForKey:kUserMessage_shopName];
    [userDefault removeObjectForKey:kUserMessage_qcode];
    [userDefault removeObjectForKey:kUserMessage_username];
    [userDefault removeObjectForKey:kUserMessage_userId];
    [userDefault removeObjectForKey:kUserMessage_userLogo];
    _logo = nil;
    _userToken = nil;
    _phone = nil;
    _power = nil;
     _qcode = nil;
     _username = nil;
    _shopName = nil;
    _userId = nil;
    [userDefault synchronize];
}
- (void)saveUserMessage:(PPSSLoginModel *)model {
    self.userToken = model.token;
    _shopName = model.shopName;
    _phone = model.phone;
    self.power = model.power;
    _qcode = model.qcode;
    _username = model.username;
    _logo = model.logo;
    NSUserDefaults *userDefault = [self getUserDefault];
    [userDefault setObject:model.username forKey:kUserMessage_username];
    [userDefault setObject:model.qcode forKey:kUserMessage_qcode];
    [userDefault setObject:model.power forKey:kUserMessage_power];
    [userDefault setObject:model.phone forKey:kUserMessage_phone];
    [userDefault setObject:model.shopName forKey:kUserMessage_shopName];
    [userDefault setObject:model.userId forKey:kUserMessage_userId];
    [userDefault setObject:model.logo forKey:kUserMessage_userLogo];
    [userDefault synchronize];
}
- (void)setPower:(NSString *)power {
    if (!KJudgeIsNullData(_power) || (KJudgeIsNullData(_power) && [_power integerValue] != [power integerValue])) {
        _power = power;
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate changeUserPower];
        [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kCashier_Module_Home_Notification object:nil];
    }
    
}
- (BOOL)isLogin {
    return KJudgeIsNullData(_userToken);
}
#pragma mark - userMessage
- (void)setUserToken:(NSString *)userToken {
    _userToken = userToken;
    [self setMessageManagerForObjectWithKey:kUserMessageToken value:userToken];
}

- (void)saveLoginNumber:(NSString *)account pwd:(NSString *)pwd isSave:(BOOL)isSave {
    NSUserDefaults *userDefault = [self getUserDefault];
    if (!isSave) {
        [userDefault removeObjectForKey:kUserMessagePwd];
        [userDefault removeObjectForKey:kUserMessageAccount];
    }else {
        [userDefault setObject:account forKey:kUserMessageAccount];
        [userDefault setObject:pwd forKey:kUserMessagePwd];
    }
    [userDefault synchronize];
}
- (void)saveUserName:(NSString *)userName power:(NSString *)power phone:(NSString *)phone {
    NSUserDefaults *userDefault = [self getUserDefault];
    [userDefault setObject:userName forKey:kUserMessage_username];
    [userDefault setObject:power forKey:kUserMessage_power];
    [userDefault setObject:phone forKey:kUserMessage_phone];
     [userDefault synchronize];
    _username = userName;
    self.power = power;
    _phone = phone;
}
- (NSString *)getLoginAccount {
    return [self getMessageManagerForObjectWithKey:kUserMessageAccount];
}
- (NSString *)getLoginPassword {
    return [self getMessageManagerForObjectWithKey:kUserMessagePwd];
}
- (void)setLoginPassword:(NSString *)password {
    [self setMessageManagerForObjectWithKey:kUserMessagePwd value:password];
}
#pragma mark 设置别名
- (void)setUserId:(NSString *)userId {
    if (!KJudgeIsNullData(_userId) || ![_userId isEqualToString:userId]) {
        _userId = userId;
        [self loginPushWithAlias:_userId];
    }
}
- (void)setIsRegisterAlia:(BOOL)isRegisterAlia {
    _isRegisterAlia = isRegisterAlia;
    [self setMessageManagerForBoolWithKey:kNoticeIsOpen value:isRegisterAlia];
}
- (void)loginPushWithAlias:(NSString *)userId {
    @weakify(self)
    self.isRegisterAlia = YES;
    [JPUSHService setAlias:userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        @strongify(self)
        if (iResCode != 0) {
            if (self.currentType != 0) {
                self.currentType --;
            }
            self.currentType += 1;
            [self monitorNetChange];
        }else if(self.currentType > 0) {
            self.currentType --;
        }else {
            if (_reachabilityManager) {
                [self.reachabilityManager stopMonitoring];
            }
        }
    } seq:req++];
}
- (void)loginOutPushWithAlias {
    self.isRegisterAlia = NO;
    WS(ws)
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode != 0) {
            if (ws.currentType != 0) {
                ws.currentType -= 2;
            }
            ws.currentType += 2;
            [ws monitorNetChange];
        }else if(self.currentType > 0) {
            ws.currentType -= 2;
        }else {
            if (_reachabilityManager) {
                [self.reachabilityManager stopMonitoring];
            }
        }
    } seq:req++];
}
- (void)monitorNetChange {
    if (self.currentType > 0) {
        [self.reachabilityManager startMonitoring];
    }else {
         [self.reachabilityManager stopMonitoring];
    }
}
- (AFNetworkReachabilityManager *)reachabilityManager {
    if (!_reachabilityManager) {
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        @weakify(self)
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                @strongify(self)
                if (self.currentType % 2 == 1) {
                    [self loginPushWithAlias:self.userId];
                }else if (self.currentType % 2 == 0 || self.currentType > 1){
                    [self loginOutPushWithAlias];
                }
            }
        }];
    }
    return _reachabilityManager;
}
- (void)cleanAlias {
    @weakify(self)
    if (!self.isRegisterAlia) {
        [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0 && KJudgeIsNullData(iAlias)) {
                @strongify(self)
                [self loginOutPushWithAlias];
            }
        } seq:req++];
    }
}
- (void)isHasRegisterAlias {
    if (self.isRegisterAlia) {
        @weakify(self)
        [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0 && !KJudgeIsNullData(iAlias)) {
                @strongify(self)
                [self loginPushWithAlias:self.userId];
            }else if(![iAlias isEqualToString:self.userId] && iResCode == 0) {
                [self loginOutPushWithAlias];
                [self loginPushWithAlias:self.userId];
            }
        } seq:req++];
    }
}

#pragma mark 定时器
- (void)timerFireMethod {
    if (self.loginCodeTime <= 0 && self.forgetCodeTime <= 0){
        [_codeTimer invalidate];
        _codeTimer = nil;
    }else {
        if (self.loginCodeTime > 0) {
            self.loginCodeTime --;
        }
        if (self.forgetCodeTime > 0) {
            self.forgetCodeTime --;
        }
    }
}
- (void)startTimer {
    if (self.loginCodeTime > 0 || self.forgetCodeTime > 0) {
        if (!_codeTimer) {
            _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        }
    }
}
- (void)startLoginTimer {
    self.loginCodeTime = 60;
    [self startTimer];
}
- (void)startForgetTimer {
    self.forgetCodeTime = 60;
    [self startTimer];
}
#pragma mark 提示框的控制
//最大是3个
- (void)showAlertView:(id)alertView weight:(NSInteger)weight {
    if (weight > 3) {
        return;
    }
    if (_isShow) {
        if (weight > _currentWeight) {
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _alterCount ++;
        }else {
            UIAlertView *alter = [self.alertListArray objectAtIndex:_currentWeight];
            [alter dismissWithClickedButtonIndex:0 animated:NO];
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _alterCount ++;
            [self showView:alertView];
        }
    }else {
        [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
        _currentWeight = weight;
        _alterCount ++;
        _isShow = YES;
       [self showView:alertView];
    }
}
- (void)hidenAlertView {
    if (_alertListArray && _alterCount > 0) {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount --;
        _currentWeight = -1;
        for (int i = 0; i < _alertListArray.count; i++) {
            id alter = [_alertListArray objectAtIndex:i];
            if ([alter isKindOfClass:[UIAlertView class]] || [alter isKindOfClass:[UIView class]]) {
                _currentWeight = i;
                if (i == 1 || (_currentWeight > 1 && [self isLogin])) {
                    [self showView:alter];;
                    break;
                }else {
                    [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
                    _alterCount -- ;
                    _currentWeight = -1;
                }
            }
        }
        if (_currentWeight < 0) {
            _alterCount = 0;
        }
    }else {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount -- ;
        _currentWeight = -1;
        _isShow = NO;
    }
    if (_alterCount == 0) {
        _isShow = NO;
    }
}
- (void)showView:(id)view {
    if ([view isKindOfClass:[UIAlertView class]]) {
        [((UIAlertView *)view) show];
    }else if ([view isKindOfClass:[UIView class]]){
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}
- (NSMutableArray *)alertListArray {
    if (!_alertListArray) {
        _alterCount = 0;
        _currentWeight = -1;
        _alertListArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _alertListArray;
}
@end
