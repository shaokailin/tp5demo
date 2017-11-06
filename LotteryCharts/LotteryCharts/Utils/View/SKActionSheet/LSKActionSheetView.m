//
//  HSPActionSheetView.m
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKActionSheetView.h"

@implementation LSKActionSheetView
{
    NSMutableArray *_otherBtnsArray;
    UIView *_bgView;
    UIView *_contentView;
    LSKActionSheetBlock _block;
}

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle clcikIndex:(LSKActionSheetBlock)seletedBlock otherButtonTitles:(NSString *)otherButtonTitles, ...{
    if (self = [self init]) {
        _block = seletedBlock;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
        {
            if (_otherBtnsArray == nil) {
                _otherBtnsArray = [[NSMutableArray alloc]initWithCapacity:3];
            }
            [_otherBtnsArray addObject:arg];
        }
        va_end(args);
        [self initializeMainView:cancelButtonTitle];
    }
    
    return self;
}
//初始化界面
- (void)initializeMainView:(NSString *)cancle {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *cancleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleClick)];
    [bgView addGestureRecognizer:cancleTap];
    bgView.alpha = 0;
    _bgView = bgView;
    
    //内容界面
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor clearColor];
    _contentView = contentView;
    [self addSubview:contentView];
    CGFloat height = 0;
    if (_otherBtnsArray && _otherBtnsArray.count > 0) {
        for (int i = 1; i <= _otherBtnsArray.count; i++) {
            NSString *title = [_otherBtnsArray objectAtIndex:i - 1];
            UIButton *funcBtn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:self action:@selector(actionSheetClick:) textfont:15 textColor:KColorUtilsString(kActionSheetText_Color) backgroundColor:[UIColor whiteColor] backgroundImage:nil];
            funcBtn.tag = 200 + i;
            funcBtn.frame = CGRectMake(0, height, SCREEN_WIDTH, 44);
            [_contentView addSubview:funcBtn];
            height += 44;
            if (i != _otherBtnsArray.count) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 0.5)];
                lineView.backgroundColor = KColorUtilsString(kActionSheetLine_Color);
                [_contentView addSubview:lineView];
                height += 0.5;
            }
        }
    }
    //判断是否有取消的按钮值
    if (KJudgeIsNullData(cancle)) {
        if (_otherBtnsArray && _otherBtnsArray.count > 0) {
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *bluredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            [bluredEffectView setFrame:CGRectMake(0,height,SCREEN_WIDTH, 10)];
            [_contentView addSubview:bluredEffectView];
            height += 10;
        }
        UIButton *cancleBtn = [LSKViewFactory initializeButtonWithTitle:cancle nornalImage:nil selectedImage:nil target:self action:@selector(actionSheetClick:) textfont:15 textColor:KColorUtilsString(kActionSheetText_Color) backgroundColor:[UIColor whiteColor] backgroundImage:nil];
        cancleBtn.tag = 200;
        cancleBtn.frame = CGRectMake(0, height, SCREEN_WIDTH, 44);
        [_contentView addSubview:cancleBtn];
        height += 44;
    }
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.bounds));
    _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, height);
    [self insertSubview:bgView atIndex:0];
}
- (void)actionSheetClick:(UIButton *)btn {
    if (_block) {
        _block(btn.tag - 200);
    }
    [self hidenViewClick];
}
- (void)cancleClick {
    if (_block) {
        _block(0);
    }
    [self hidenViewClick];
}
- (void)hidenViewClick {
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0;
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGRectGetHeight(_contentView.frame));
    } completion:^(BOOL finished) {
        for (UIView *subView in _contentView.subviews) {
            [subView removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}
- (void)showInView {
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 1.0;
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT - CGRectGetHeight(_contentView.frame), SCREEN_WIDTH,CGRectGetHeight(_contentView.frame));
    }];
}
@end
