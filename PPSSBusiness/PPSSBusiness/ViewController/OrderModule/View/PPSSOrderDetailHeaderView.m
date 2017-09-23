//
//  PPSSOrderDetailHeaderView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderDetailHeaderView.h"

@implementation PPSSOrderDetailHeaderView
{
    UILabel *_moneyLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIView *circleView = [[UIView alloc]init];
    circleView.backgroundColor = [UIColor whiteColor];
    ViewRadius(circleView, 5.0);
    circleView.layer.masksToBounds = YES;
    [self addSubview:circleView];
    WS(ws)
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(15);
        make.top.equalTo(ws).with.offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"收款金额" font:0 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:ColorHexadecimal(Color_APP_MAIN, 1.0)];
    titleLbl.font = FontBoldInit(12);
    ViewRadius(titleLbl, 5.0);
    titleLbl.layer.masksToBounds = YES;
    [circleView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(circleView).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(75, 35));
        make.centerX.equalTo(circleView);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = COLOR_WHITECOLOR;
    [self addSubview:contentView];
    CGFloat contentViewHeight = CGRectGetHeight(self.bounds) - 20 - 30;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(circleView);
        make.top.equalTo(circleView.mas_bottom).with.offset(-5);
        make.height.mas_equalTo(contentViewHeight);
    }];
    
    _moneyLbl = [LSKViewFactory initializeLableWithText:nil font:40 textColor:ColorHexadecimal(Color_Text_Pink, 1.0) textAlignment:1 backgroundColor:nil];
    [contentView addSubview:_moneyLbl];
    [_moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).with.offset(11);
        make.centerX.equalTo(contentView);
    }];
    [self changeMoneyString:@"0.00"];
    CGFloat lineWith = 21 + 5;
    NSInteger count = floor((SCREEN_WIDTH - 30) / lineWith);
    CGFloat between = ((SCREEN_WIDTH - 30) - lineWith  * count + 5) / (count  - 1);
    LSKLog(@"%ld,%f",count,between);
    
    for (int i = 0; i < count ; i++) {
        @autoreleasepool{
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(i * (21 + 5 + between), contentViewHeight - 5, 21, 5)];
            NSString *imageName = (i % 2 == 0?@"orderdetai_lanxian":@"orderdetai_heixian");
            lineImage.image = ImageNameInit(imageName);
            [contentView addSubview:lineImage];
        }
    }
    
}
- (void)changeMoneyString:(NSString *)money {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:NSStringFormat(@"￥%@",money)];
    [attribute addAttribute:NSFontAttributeName value:FontNornalInit(18) range:NSMakeRange(0, 1)];
    _moneyLbl.attributedText = attribute;
}
@end
