//
//  PPSSPPSSActivityDetailAttributeTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailAttributeTableViewCell.h"

@implementation PPSSActivityDetailAttributeTableViewCell
{
    UILabel *_leftLbl;
    UILabel *_rightLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithSuport:(NSString *)support {
    if ([support isHasValue]) {
        _rightLbl.text = support;
    }
    
}
- (void)_layoutMainView {
    WS(ws)
    _leftLbl = [PPSSPublicViewManager initLblForColor3333:@"活动力度" textAlignment:0];
    _leftLbl.font = FontBoldInit(12);
    [self.contentView addSubview:_leftLbl];
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).with.offset(15);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(7);
    }];
    _rightLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:@"请输入活动力度，如15%"];
    [attribute addAttribute:NSForegroundColorAttributeName value:ColorHexadecimal(Color_APP_MAIN, 1.0) range:NSMakeRange(attribute.string.length - 3, 3)];
    _rightLbl.attributedText = attribute;
    [self.contentView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrow.mas_left).with.offset(-8);
        make.centerY.equalTo(ws.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
