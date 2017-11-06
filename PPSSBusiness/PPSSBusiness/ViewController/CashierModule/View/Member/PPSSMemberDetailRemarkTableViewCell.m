//
//  PPSSMemberDetailRemarkTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberDetailRemarkTableViewCell.h"

@implementation PPSSMemberDetailRemarkTableViewCell
{
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
- (void)setupContentWithLeft:(NSString *)left remark:(NSString *)remark {
    _leftLbl.text = left;
    _rightLbl.text = remark;
}
- (void)_layoutMainView {
    UILabel *leftLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    _leftLbl = leftLbl;
    [self.contentView addSubview:_leftLbl];
    WS(ws)
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).with.offset(15);
        make.height.mas_equalTo(44);
    }];
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(leftLbl);
    }];
    UIView *inputView = [[UIView alloc]init];
    ViewRadius(inputView, 3.0);
    ViewBorderLayer(inputView, ColorHexadecimal(kMainBackground_Color, 1.0), LINEVIEW_WIDTH / 2.0);
    [self.contentView addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(leftLbl.mas_bottom);
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.bottom.equalTo(ws.contentView).with.offset(-10);
    }];
    _rightLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _rightLbl.numberOfLines = 0;
    [inputView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(inputView).with.offset(5);
        make.right.equalTo(inputView).with.offset(-5);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
