//
//  PPSSActivityAlertView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/25.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityAlertView.h"

@implementation PPSSActivityAlertView
{
    UIView *_contentView;
    NSString *_alertTitle;
}
- (instancetype)initWithAlertTitle:(NSString *)title {
    if (self = [super init]) {
        _alertTitle = title;
        [self _layoutMainView];
    }
    return self;
}
- (void)showInView {
     [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
    
}
- (void)_layoutMainView {
    self.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    [self addSubview:_contentView];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.layer.cornerRadius = 10.0;
    titleView.backgroundColor = COLOR_WHITECOLOR;
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor6666:@"温馨提示"];
    titleLbl.textAlignment = 1;
    titleLbl.font = FontNornalInit(16);
    [titleView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(titleView);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *detailLbl = [PPSSPublicViewManager initLblForColor6666:_alertTitle];
    detailLbl.font = FontNornalInit(14);
    detailLbl.numberOfLines = 0;
    [titleView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).with.offset(15);
        make.right.equalTo(titleView).with.offset(-15);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(10);
    }];
    
    
    [_contentView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).with.offset(15);
        make.left.bottom.equalTo(contentView);
        make.right.equalTo(contentView).with.offset(-15);
    }];
    
    UIButton *closeBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"activityClose" target:self action:@selector(hidenView)];
    [_contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    WS(ws)
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(275, 220 + 15));
    }];
}
- (void)hidenView {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
