//
//  PPSSIncomeMessageTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeMessageTableViewCell.h"

@implementation PPSSIncomeMessageTableViewCell
{
    UILabel *_rightLbl;
    UILabel *_leftLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right titleType:(NSInteger)titleType moneyType:(NSInteger)moneyType {
    _leftLbl.text = left;
    _rightLbl.text = right;
    if (titleType == 0) {
        _leftLbl.textColor = ColorHexadecimal(Color_Text_3333, 1.0);
        _leftLbl.font = FontBoldInit(14);
    }else {
        _leftLbl.textColor = ColorHexadecimal(Color_Text_6666, 1.0);
        _leftLbl.font = FontNornalInit(14);
    }
    if (moneyType == 0) {
        _rightLbl.textColor = ColorHexadecimal(Color_Text_6666, 1.0);
    }else {
        _rightLbl.textColor = ColorHexadecimal(Color_Text_Pink, 1.0);
    }
}
- (void)_layoutMainView {
    _leftLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _leftLbl.font = FontNornalInit(14);
    [self.contentView addSubview:_leftLbl];
    WS(ws)
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).with.offset(15);
    }];
    _rightLbl = [PPSSPublicViewManager initLblForColorPink:@"￥0.00" textAlignment:0];
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
