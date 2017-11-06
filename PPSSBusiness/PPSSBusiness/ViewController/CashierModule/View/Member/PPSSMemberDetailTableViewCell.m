//
//  PPSSMemberDetailTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberDetailTableViewCell.h"

@implementation PPSSMemberDetailTableViewCell
{
    NSInteger _currentType;
    UILabel *_rightLbl;
    UILabel *_leftLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right type:(NSInteger)type {
    _leftLbl.text = left;
    _rightLbl.text = right;
    if (type != _currentType) {
        _currentType = type;
        [self changeTextColor];
    }
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
    _leftLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    [self.contentView addSubview:_leftLbl];
    WS(ws)
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).with.offset(15);
    }];
    _rightLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    [self.contentView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
