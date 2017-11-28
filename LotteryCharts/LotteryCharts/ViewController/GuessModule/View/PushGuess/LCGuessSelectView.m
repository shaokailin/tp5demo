//
//  LCGuessSelectView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessSelectView.h"
#import "LCSelectSizeView.h"
#import "LCSelectTwoYardsView.h"
@interface LCGuessSelectView ()
{
    NSInteger _currentType;
}
@property (nonatomic, weak) LCSelectSizeView *sizeView;
@property (nonatomic, weak) LCSelectTwoYardsView *twoView;
@property (nonatomic, weak) UIImageView *topArrowImage;
@end
@implementation LCGuessSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (NSString *)getSelectData {
    if (_currentType == 2) {
        return [self.twoView getSelect];
    }else {
        return [self.sizeView getSelect];
    }
}
- (NSString *)getMoneyData {
    if (_currentType == 2) {
        return self.twoView.payField.text;
    }else {
        return self.sizeView.payField.text;
    }
}
- (NSString *)getNumberData {
    if (_currentType == 2) {
        return self.twoView.countField.text;
    }else {
        return self.sizeView.countField.text;
    }
}
- (void)changeType:(UIButton *)btn {
    if (!btn.selected) {
        UIButton *otherBtn = [self viewWithTag:300 + _currentType];
        otherBtn.selected = NO;
        _currentType = btn.tag - 300;
        btn.selected = YES;
        CGRect frame = self.topArrowImage.frame;
        frame.origin.x = CGRectGetMidX(btn.frame) - frame.size.width / 2.0;
        self.topArrowImage.frame = frame;
        if (self.selectBlock) {
            self.selectBlock(_currentType);
        }
        CGRect selfFrame = self.frame;
        if (_currentType == 3) {
            self.twoView.hidden = YES;
            self.sizeView.hidden = NO;
            selfFrame.size.height = 369;
        }else {
            self.twoView.hidden = NO;
            self.sizeView.hidden = YES;
            selfFrame.size.height = 417;
        }
        self.frame = selfFrame;
    }
}
- (void)sureClick {
    if (self.selectBlock) {
        self.selectBlock(5);
    }
}
- (void)_layoutMainView {
    _currentType = 2;
   
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"竞猜类型" font:15 textColor: ColorHexadecimal(0x434343, 1.0) textAlignment:1 backgroundColor:nil];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(ws).with.offset(18);
    }];
    
    UIButton * twoBtn = [LSKViewFactory initializeButtonWithTitle:@"杀两码" nornalImage:nil selectedImage:nil target:self action:@selector(changeType:) textfont:15 textColor:ColorHexadecimal(0x4a4a4a, 1.0) backgroundColor:nil backgroundImage:@"gradrect"];
    twoBtn.tag = 302;
    [twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [twoBtn setBackgroundImage:ImageNameInit(@"redrect") forState:UIControlStateSelected];
    twoBtn.selected = YES;
    [self addSubview:twoBtn];
    [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    
    UIButton * sizeBtn = [LSKViewFactory initializeButtonWithTitle:@"猜大小" nornalImage:nil selectedImage:nil target:self action:@selector(changeType:) textfont:15 textColor:ColorHexadecimal(0x4a4a4a, 1.0) backgroundColor:nil backgroundImage:@"gradrect"];
    sizeBtn.tag = 303;
    [sizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [sizeBtn setBackgroundImage:ImageNameInit(@"redrect") forState:UIControlStateSelected];
    [self addSubview:sizeBtn];
    [sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoBtn.mas_right).with.offset(10);
        make.top.width.bottom.equalTo(twoBtn);
    }];
    
    UIImageView *arrowImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"toparrow")];
    arrowImage.frame = CGRectMake(62.5, 84, 15, 10);
    self.topArrowImage = arrowImage;
    [self addSubview:arrowImage];
    
    UIButton *sureBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(sureClick) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"guessbtn"];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.right.bottom.equalTo(ws).with.offset(-20);
        make.height.mas_equalTo(45);
    }];
    self.twoView.hidden = NO;
}
- (LCSelectTwoYardsView *)twoView {
    if (!_twoView) {
        LCSelectTwoYardsView *twoView = [[[NSBundle mainBundle] loadNibNamed:@"LCSelectTwoYardsView" owner:self options:nil] lastObject];
        _twoView = twoView;
        [self addSubview:twoView];
        WS(ws)
        [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(10);
            make.height.mas_equalTo(244);
            make.right.equalTo(ws).with.offset(-10);
            make.top.equalTo(ws.topArrowImage.mas_bottom);
        }];
    }
    return _twoView;
}
- (LCSelectSizeView *)sizeView {
    if (!_sizeView) {
        LCSelectSizeView *sizeView = [[[NSBundle mainBundle] loadNibNamed:@"LCSelectSizeView" owner:self options:nil] lastObject];
        _sizeView = sizeView;
        [self addSubview:sizeView];
        WS(ws)
        [sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(10);
            make.height.mas_equalTo(194);
            make.right.equalTo(ws).with.offset(-10);
            make.top.equalTo(ws.topArrowImage.mas_bottom);
        }];
    }
    return _sizeView;
}


@end
