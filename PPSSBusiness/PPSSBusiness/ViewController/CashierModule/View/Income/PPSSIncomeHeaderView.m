//
//  PPSSIncomeHeaderView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeHeaderView.h"
#import "PPSSOrderHomeButtonView.h"
@interface PPSSIncomeHeaderView ()
@property (nonatomic, weak) PPSSOrderHomeButtonView *dateBtn;
@property (nonatomic, weak) PPSSOrderHomeButtonView *shopBtn;
@end
@implementation PPSSIncomeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
#pragma mark -private
- (void)dateClickEvent {
    if (self.clickBlock) {
        self.clickBlock(OrderHomeSearchClickType_Date);
    }
}
- (void)shopClickEvent {
    if (self.clickBlock) {
        self.clickBlock(OrderHomeSearchClickType_Shop);
    }
}
- (void)changeBtnText:(NSString *)text type:(OrderHomeSearchClickType)type {
    if (type == OrderHomeSearchClickType_Date) {
        [self.dateBtn setupTitle:text];
    }else {
        [self.shopBtn setupTitle:text];
    }
}
- (NSString *)dateTime {
    return self.dateBtn.dateString;
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    [self _layoutButtonView];
}
- (void)_layoutButtonView {
    UIView *selectView = [[UIView alloc]init];
    selectView.backgroundColor = COLOR_WHITECOLOR;
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [selectView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LINEVIEW_WIDTH, 16));
        make.center.equalTo(selectView);
    }];
    PPSSOrderHomeButtonView *dateBtn = [[PPSSOrderHomeButtonView alloc]initWithType:OrderHomeButtonType_Date];
    [dateBtn addTarget:self action:@selector(dateClickEvent) forControlEvents:UIControlEventTouchUpInside];
    self.dateBtn = dateBtn;
    [selectView addSubview:dateBtn];
    
    PPSSOrderHomeButtonView *shopBtn = [[PPSSOrderHomeButtonView alloc]initWithType:OrderHomeButtonType_Shop];
    [shopBtn addTarget:self action:@selector(shopClickEvent) forControlEvents:UIControlEventTouchUpInside];
    self.shopBtn = shopBtn;
    [selectView addSubview:shopBtn];
    
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(selectView);
    }];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateBtn.mas_right).with.offset(LINEVIEW_WIDTH);
        make.right.bottom.top.equalTo(selectView);
        make.width.equalTo(dateBtn.mas_width);
    }];
    [self addSubview:selectView];
    WS(ws)
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(ws).with.offset(-LINEVIEW_WIDTH);
        make.height.mas_equalTo(45);
    }];
}
@end
