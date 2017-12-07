//
//  LCSpaceMyOrderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceMyOrderView.h"

@implementation LCSpaceMyOrderView
{
    UILabel *_indexLbl;
    UIImageView *_userPhoto;
    UILabel *_moneyLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithIndex:(NSString *)index photo:(NSString *)photo money:(NSString *)money {
    _indexLbl.text = index;
    _moneyLbl.text = NSStringFormat(@"%@金币",money);
    
}
- (void)_layoutMainView {
    self.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    self.layer.shadowOffset=CGSizeMake(2,2);
    self.layer.shadowOpacity=0.5;
    self.layer.shadowRadius=0;
    
    UILabel *indexLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor redColor] textAlignment:1 backgroundColor:nil];
    _indexLbl = indexLbl;
    [self addSubview:indexLbl];
    WS(ws)
    [indexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(11);
        make.centerY.equalTo(ws);
    }];
    
    UIImageView *photoImage = [[UIImageView alloc]init];
    ViewBoundsRadius(photoImage, 35 / 2.0);
    photoImage.backgroundColor = ColorHexadecimal(0xbfbfbf, 1.0);
    _userPhoto = photoImage;
    [self addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(indexLbl.mas_right).with.offset(6);
        make.centerY.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    if (KJudgeIsNullData(kUserMessageManager.logo)) {
        [photoImage sd_setImageWithURL:[NSURL URLWithString:kUserMessageManager.logo] placeholderImage:nil];
    }
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"我" font:15 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).with.offset(11);
        make.centerY.equalTo(ws);
    }];
    
    UILabel *moneyLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:ColorHexadecimal(0xf6a623, 1.0) textAlignment:2 backgroundColor:nil];
    _moneyLbl = moneyLbl;
    [self addSubview:moneyLbl];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-15);
        make.centerY.equalTo(ws);
    }];
    
    UILabel *otherLbl = [LSKViewFactory initializeLableWithText:@"打赏过该码师" font:10 textColor:ColorHexadecimal(0xbfbfbf,1.0) textAlignment:1 backgroundColor:nil];
    [self addSubview:otherLbl];
    [otherLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyLbl.mas_left).with.offset(-6);
        make.centerY.equalTo(ws);
    }];
    
    
}
@end
