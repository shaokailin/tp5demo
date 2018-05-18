//
//  LCUserMessageManager.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageManager.h"
#import "SynthesizeSingleton.h"
#import "LCUserMessageModel.h"
#import <JPUSHService.h>
#import <AFNetworking/AFNetworking.h>
static NSString * const kUserMessage_Token = @"User_TOKENToken2";
static NSString * const kUserMessage_Mchid = @"user_Mchid2";
static NSString * const kUserMessage_Uid = @"user_Uid";
static NSString * const kUserMessage_Photo = @"user_Photo";
static NSString * const kUserMessage_NickName = @"user_NickName2";
static NSString * const kUserMessage_Money = @"user_Money2";
static NSString * const kUserMessage_YMoney = @"user_YMoney2";
static NSString * const kUserMessage_SMoney = @"user_SMoney2";
static NSString * const kUserMessage_bgLogo = @"user_bgLogo2";
static NSString * const kUserMessage_mchno = @"user_mchno2";

static NSString * const kNoticeIsOpen = @"NoticeIsOpen";
static NSInteger req = 1000;

@interface LCUserMessageManager ()
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
@implementation LCUserMessageManager
SYNTHESIZE_SINGLETON_CLASS(LCUserMessageManager);

- (instancetype)init {
    if (self = [super init]) {
        _loginCodeTime = 0;
        _forgetCodeTime = 0;
        [self getUserMessage];
    }
    return self;
}
- (void)getUserMessage {
    _isRegisterAlia = [self getMessageManagerForBoolWithKey:kNoticeIsOpen];
    _token = [self getMessageManagerForObjectWithKey:kUserMessage_Token];
    if ([self isLogin]) {
        _logo = [self getMessageManagerForObjectWithKey:kUserMessage_Photo];
        _userId = [self getMessageManagerForObjectWithKey:kUserMessage_Uid];
        _nickName = [self getMessageManagerForObjectWithKey:kUserMessage_NickName];
        _money = [self getMessageManagerForObjectWithKey:kUserMessage_Money];
        _yMoney = [self getMessageManagerForObjectWithKey:kUserMessage_YMoney];
        _sMoney = [self getMessageManagerForObjectWithKey:kUserMessage_SMoney];
        _bglogo = [self getMessageManagerForObjectWithKey:kUserMessage_bgLogo];
        _mch_no = [self getMessageManagerForObjectWithKey:kUserMessage_mchno];
        _isShowCare = ![self getMessageManagerForBoolWithKey:kNoticeSettingCare];
        _isShowReply = ![self getMessageManagerForBoolWithKey:kNoticeSettingReply];
        _isShowShang = ![self getMessageManagerForBoolWithKey:kNoticeSettingShange];
        _isShowSystem = ![self getMessageManagerForBoolWithKey:kNoticeSettingSystem];
    }
}
- (void)setToken:(NSString *)token {
    _token = token;
    [self setMessageManagerForObjectWithKey:kUserMessage_Token value:token];
}
- (void)setIsShowCare:(BOOL)isShowCare {
    _isShowCare = isShowCare;
    [self setMessageManagerForBoolWithKey:kNoticeSettingCare value:!_isShowCare];
}
- (void)setIsShowReply:(BOOL)isShowReply {
    _isShowReply = isShowReply;
    [self setMessageManagerForBoolWithKey:kNoticeSettingReply value:!isShowReply];
}
- (void)setIsShowShang:(BOOL)isShowShang {
    _isShowShang = isShowShang;
    [self setMessageManagerForBoolWithKey:kNoticeSettingShange value:!isShowShang];
}
- (void)setIsShowSystem:(BOOL)isShowSystem {
    _isShowSystem = isShowSystem;
    [self setMessageManagerForBoolWithKey:kNoticeSettingSystem value:!isShowSystem];
}
- (void)setMoney:(NSString *)money {
    _money = money;
    [self setMessageManagerForObjectWithKey:kUserMessage_Money value:money];
}
- (void)setYMoney:(NSString *)yMoney {
    _yMoney = yMoney;
    [self setMessageManagerForObjectWithKey:kUserMessage_YMoney value:yMoney];
}
- (void)setSMoney:(NSString *)sMoney {
    _sMoney = sMoney;
    [self setMessageManagerForObjectWithKey:kUserMessage_SMoney value:sMoney];
}
- (void)setLogo:(NSString *)logo {
    _logo = logo;
    [self setMessageManagerForObjectWithKey:kUserMessage_Photo value:logo];
}
- (void)setBglogo:(NSString *)bglogo {
    _bglogo = bglogo;
    [self setMessageManagerForObjectWithKey:kUserMessage_bgLogo value:bglogo];
}
- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    [self setMessageManagerForObjectWithKey:kUserMessage_NickName value:nickName];
}
- (BOOL)isLogin {
    return KJudgeIsNullData(self.token);
}
- (void)saveUserMessage:(LCUserMessageModel *)model isLogin:(BOOL)isLogin {
    if (isLogin) {
        [self loginPushWithAlias:model.userId];
    }
    _token = model.token;
    _userId = model.userId;
    _logo = model.logo;
    _nickName = model.nickname;
    _money = model.money;
    _yMoney = model.ymoney;
    _sMoney = model.smoney;
    _bglogo = model.bglogo;
    _mch_no = model.mch_no;
    NSUserDefaults *userDefaults = [self getUserDefault];
    [userDefaults setObject:model.token forKey:kUserMessage_Token];
    [userDefaults setObject:model.sex forKey:kUserMessage_Sex];
    [userDefaults setObject:model.nickname forKey:kUserMessage_NickName];
    [userDefaults setObject:model.birthday forKey:kUserMessage_Birthday];
    [userDefaults setObject:model.money forKey:kUserMessage_Money];
    if (isLogin) {
        [userDefaults setObject:model.mobile forKey:kUserMessage_Mobile];
    }
    [userDefaults setObject:model.userId forKey:kUserMessage_Uid];
    [userDefaults setObject:model.mchid forKey:kUserMessage_Mchid];
    [userDefaults setObject:model.logo forKey:kUserMessage_Photo];
    [userDefaults setObject:model.ymoney forKey:kUserMessage_YMoney];
    [userDefaults setObject:model.smoney forKey:kUserMessage_SMoney];
    [userDefaults setObject:model.bglogo forKey:kUserMessage_bgLogo];
    [userDefaults setObject:model.mch_no forKey:kUserMessage_mchno];
    [userDefaults synchronize];
    
}
- (void)removeUserMessage {
    [self loginOutPushWithAlias];
    _token = nil;
    _userId = nil;
    _logo = nil;
    _nickName = nil;
    _yMoney = nil;
    _money = nil;
    _sMoney = nil;
    _bglogo = nil;
    _mch_no = nil;
    [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kLoginOutChange_Notice object:nil];
    NSUserDefaults *userDefaults = [self getUserDefault];
    [userDefaults removeObjectForKey:kUserMessage_Token];
    [userDefaults removeObjectForKey:kUserMessage_Sex];
    [userDefaults removeObjectForKey:kUserMessage_NickName];
    [userDefaults removeObjectForKey:kUserMessage_Mobile];
    [userDefaults removeObjectForKey:kUserMessage_Birthday];
    [userDefaults removeObjectForKey:kUserMessage_Money];
    [userDefaults removeObjectForKey:kUserMessage_Uid];
    [userDefaults removeObjectForKey:kUserMessage_Mchid];
    [userDefaults removeObjectForKey:kUserMessage_Photo];
    [userDefaults removeObjectForKey:kUserMessage_YMoney];
    [userDefaults removeObjectForKey:kUserMessage_bgLogo];
    [userDefaults removeObjectForKey:kUserMessage_mchno];
    [userDefaults synchronize];
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
            id alterView1 = [self.alertListArray objectAtIndex:_currentWeight];
            if ([alterView1 isKindOfClass:[UIAlertView class]]) {
                UIAlertView *alter = (UIAlertView *)alterView1;
                [alter dismissWithClickedButtonIndex:0 animated:NO];
            }else if ([alterView1 isKindOfClass:[UIView class]]){
                UIView *alter = (UIView *)alterView1;
                [alter removeFromSuperview];
            }
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _currentWeight = weight;
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


#pragma mark 设置别名
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
            if (self->_reachabilityManager) {
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
            if (self->_reachabilityManager) {
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
    if (self.isRegisterAlia || (!self.isRegisterAlia && [self isLogin])) {
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
@end
