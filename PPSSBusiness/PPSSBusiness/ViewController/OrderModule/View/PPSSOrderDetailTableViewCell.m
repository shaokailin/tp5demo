//
//  PPSSOrderDetailTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderDetailTableViewCell.h"

@implementation PPSSOrderDetailTableViewCell
{
    NSInteger _currentType;
    UILabel *_rightLbl;
    UILabel *_leftLbl;
    UIView *_lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}

- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right type:(NSInteger)type isLast:(BOOL)isLast {
    _leftLbl.text = left;
    _rightLbl.text = right;
    if (type != _currentType) {
        _currentType = type;
        [self changeTextColor];
    }
    _lineView.hidden = isLast;
}
- (void)changeTextColor {
    if (_currentType == 1) {
        _rightLbl.textColor = ColorHexadecimal(Color_Text_6666, 1.0);
    }else {
        _rightLbl.textColor = ColorHexadecimal(Color_Text_Pink, 1.0);
    }
}

- (void)_layoutMainView {
    _currentType = 1;
    UIView *contentView = [[UIView alloc]init];
    ViewRadius(contentView, 5);
    contentView.backgroundColor = COLOR_WHITECOLOR;
    [self.contentView addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    _leftLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    [contentView addSubview:_leftLbl];
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).with.offset(10);
    }];
    
    _rightLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    [contentView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).with.offset(-10);
        make.centerY.equalTo(contentView);
    }];
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_WHITECOLOR;
    [contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(10);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_WHITECOLOR;
    _lineView = lineView;
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(contentView);
        make.height.mas_equalTo(10);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
