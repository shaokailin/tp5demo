//
//  LCUserMessageManager.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageManager.h"
#import "SynthesizeSingleton.h"
@interface LCUserMessageManager ()
{
    NSTimer *_codeTimer;
    BOOL _isShow;
    NSInteger _currentWeight;
    BOOL _alterCount;
}
@property (nonatomic, strong) NSMutableArray *alertListArray;
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
    
}
- (BOOL)isLogin {
    return YES;
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
                if (i == 1) {//|| (_currentWeight > 1 && [self isLogin])//需要登录
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
