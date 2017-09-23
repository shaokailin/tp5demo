//
//  PPSSIncomeFooterView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeFooterView.h"

@implementation PPSSIncomeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}

- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor6666:@"手续费"];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-15);
        make.centerY.equalTo(ws);
    }];
    
    UIButton *questionBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"income_question" target:self action:@selector(questionClick)];
    [self addSubview:questionBtn];
    [questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLbl.mas_left).with.offset(-5);
        make.centerY.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
}
- (void)questionClick {
    if (self.footerBlock) {
        self.footerBlock(0);
    }
}
@end
