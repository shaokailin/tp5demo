//
//  PPSSCashierHomeCollectionViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeCollectionViewCell.h"

@implementation PPSSCashierHomeCollectionViewCell
{
    UILabel *_titleLbl;
    UILabel *_detialLbl;
    UIImageView *_iconImageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _latoutMainView];
    }
    return self;
}
- (void)setupCellContentWithTitle:(NSString *)title
                      detailTitle:(NSString *)detailTitle
                             icon:(NSString *)icon {
    _titleLbl.text = title;
    _detialLbl.text = detailTitle;
    _iconImageView.image = ImageNameInit(icon);
}
- (void)_latoutMainView {
    UIImageView *iconImageView = [[UIImageView alloc]init];
    _iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    WS(ws)
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(22);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    _titleLbl = titleLbl;
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(10);
        make.bottom.equalTo(ws.contentView.mas_centerY);
    }];
    UILabel *detailLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:ColorHexadecimal(Color_Text_CCCC, 1.0) textAlignment:0 backgroundColor:nil];
    _detialLbl = detailLbl;
    [self.contentView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_left);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(6);
        make.right.lessThanOrEqualTo(ws.contentView).with.offset(-10);
    }];
    
}
@end
